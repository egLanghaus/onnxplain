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
#eval twice (· + 2) 10




