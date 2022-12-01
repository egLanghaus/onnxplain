namespace BasicFunctions

#eval 2+2
#eval Lean.versionStringCore
#eval Lean.versionString

def sampleFunction1 x:= x*x + 3

def result1 := sampleFunction1 4573

#eval result1
#eval sampleFunction1 2
#eval println! "the result is {result1}"

def sampleFunction2 (x : Nat) := 2*x*x - x + 3
-- evaluating that guy...
def result2 := sampleFunction2 (7+4)

-- second function
#eval println! "result of apply 2nd func to (7+4) is {result2}"

-- conditionals
def sampleFunction3 (x : Int) :=
  if x > 100 then
    2*x*x - x + 3
  else
    2*x*x + x - 37


-- what ends a function, then?
-- (is this just ugly or am I missing something?)

def result3 := sampleFunction3 2

-- evaluating that one
#eval println! "result of sampleFuction3 applied to 2 is {result3}"

end BasicFunctions
-- this is how it works in Coq, I think

-- a bit about functions
def twice (f : Nat → Nat) (a : Nat) := f (f a)

-- note that "constant" is no longer a thing
opaque tester : Nat → Nat
opaque testoo : Nat → Nat
opaque natch : Nat
opaque emm : Nat

-- it is not a LaTeX style and...
-- compose key less likely than \
-- that is: try backslash + best guess
-- then search the Zulip chat!
-- (for instance \ + . )
#eval twice (· + 2) 10
#eval twice (·  + 3) 11
#eval twice (· + 4) 12

-- (remark: still 'worried' about function indentation)
-- copied from book in the other tab
#check Nat → Nat      -- type the arrow as "\to" or "\r"
#check Nat -> Nat     -- alternative ASCII notation

#check Nat × Nat      -- type the product as "\times"
#check Prod Nat Nat   -- alternative notation

#check Nat → Nat → Nat
#check Nat → (Nat → Nat)  --  same type as above

#check Nat × Nat → Nat
#check (Nat → Nat) → Nat -- a "functional"

#check Nat.succ     -- Nat → Nat
#check (0, 1)       -- Nat × Nat
#check Nat.add      -- Nat → Nat → Nat

#check Nat.succ 2   -- Nat
#check Nat.add 3    -- Nat → Nat
#check Nat.add 5 2  -- Nat
#check (5, 9).1     -- Nat
#check (5, 9).2     -- Nat

#eval Nat.succ 2   -- 3
#eval Nat.add 5 2  -- 7
#eval (5, 9).1     -- 5
#eval (5, 9).2     -- 9

-- BEGIN THEOREM PROVING (LEAN4) BOOK
def m : Nat := 1
def n : Nat := 0
def b1 : Bool := true
def b2 : Bool := false

/- a new kind of comment...! -/
#check b1
#check b2
#check b1 || b2
#check b1 && b2
#eval b1 && b2
#eval b1 || b2

#check Nat × Bool
opaque blap : Nat × Bool
#check blap
#check Prod Nat Nat
#check Nat → (Nat → Nat)
#check Nat → Nat → Nat
#check (Nat → Nat) → Nat
#check (0,1)
#check Nat.add
#check Nat.succ
#check Nat.add 2
#eval (Nat.add 2) 3
#check (Nat.add 2)
#eval (5,9).fst = (5,0).1
def α : Type := Nat
#check α 
-- see below
/-opaque γ : Type
#check γ 
-/

#check Type 
#check Type 1
def β : Type := Bool
def γ := α × β 
#check γ 
