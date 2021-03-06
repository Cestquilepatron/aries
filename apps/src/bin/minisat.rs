use aries_sat::all::Lit;
use aries_sat::cnf::CNF;
use aries_sat::{SearchParams, SearchStatus};
use std::fs;
use structopt::StructOpt;

#[derive(Debug, StructOpt)]
#[structopt(name = "minisat")]
struct Opt {
    file: String,
    #[structopt(long = "sat")]
    expected_satisfiability: Option<bool>,
}

fn main() {
    let opt = Opt::from_args();

    let filecontent = fs::read_to_string(opt.file).expect("Cannot read file");

    let clauses = parse(&filecontent).clauses;

    let mut solver = aries_sat::Solver::init(clauses, SearchParams::default());
    match solver.solve() {
        SearchStatus::Solution => {
            println!("SAT");
            if opt.expected_satisfiability == Some(false) {
                eprintln!("Error: expected UNSAT but got SAT");
                std::process::exit(1);
            }
        }
        SearchStatus::Unsolvable => {
            println!("UNSAT");

            if opt.expected_satisfiability == Some(true) {
                eprintln!("Error: expected SAT but got UNSAT");
                std::process::exit(1);
            }
        }
        _ => unreachable!(),
    }
    println!("{}", solver.stats);
}

fn parse(input: &str) -> CNF {
    let mut cnf = CNF::new();
    let mut lines_iter = input.lines().filter(|l| !l.starts_with('c'));
    let header = lines_iter.next();
    assert!(header.and_then(|h| h.chars().next()) == Some('p'));
    for l in lines_iter {
        let lits = l
            .split_whitespace()
            .map(|lit| lit.parse::<i32>().unwrap())
            .take_while(|i| *i != 0)
            .map(Lit::from_signed_int)
            .collect::<Vec<_>>();

        cnf.add_clause(&lits[..]);
    }
    cnf
}
