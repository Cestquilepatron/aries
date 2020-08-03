(define (problem strips-gripper-x-1)
   (:domain gripper-strips)
   (:objects rooma roomb roomc roomd roome roomf roomg ball9 ball8 ball7 ball6 ball5 ball4 ball3 ball2 ball1 left right)
   (:init (room rooma)
          (room roomb)
	  (room roomc)
	  (room roomd)
	  (room roome)
	  (room roomf)
	  (room roomg)
          (ball ball4)
          (ball ball3)
          (ball ball2)
          (ball ball1)
	  (ball ball5)
          (ball ball6)
          (ball ball7)
          (ball ball8)
	  (ball ball9)
          (at-robby rooma)
          (free left)
          (free right)
          (at ball4 rooma)
          (at ball3 rooma)
          (at ball2 rooma)
          (at ball1 rooma)
          (at ball5 rooma)
          (at ball6 rooma)
          (at ball7 rooma)
          (at ball8 rooma)
          (at ball9 rooma)
          (gripper left)
          (gripper right))
   (:goal (and (at ball4 roomb)
               (at ball3 roomb)
               (at ball2 roomb)
               (at ball1 roomb)
	       (at ball5 roomg)
               (at ball6 roomg)
               (at ball7 roomg)
               (at ball8 roomg)
	       (at ball9 roomg)
               )))
