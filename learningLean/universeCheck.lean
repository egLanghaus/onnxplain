-- in the beginning was the universe
universe u v w
def F (α : Type u) : Type u := Prod α α 
#check F 
def V (α : Type u) (β : Type v) := Prod α β 
#check V
def G.{q} (α : Type q) : Type q := Prod α α 
#check G 

-- really kinda dying to know what this gives us
-- guess I will forge ahead for now

#check Type 1
#check Type u 
#check Type v 
#check Type w 
#check Type 2
#check Type 3
#check Type 4

-- functions
#check λ (x : Nat) => x + 5
#check λ (x : Nat) => x - 6
#check λ x : Nat => x + 5
#check fun x : Nat => x + 5
#check Nat
#check Type 0
#check Type
#check List

-- evaluating a function
#eval (λ (x : Nat) => x*5) 10

-- conditionals
-- and three ways of doing the same thing
#check fun (x : Nat) => fun (y : Bool) => if not y then x + 1 else x + 2
#check fun x y => if not y then x + 1 else x + 2
#check fun (x : Nat) (y : Bool) => if not y then x + 1 else x + 2
def f (n : Nat) : String := toString n
def g (s : String) : Bool := s.length > 0
#check fun x : Nat => x
#check fun x : Nat => true -- remark: unused variable - cool!
#check fun x : Nat => g (f x)
#check fun x => g (f x)
#check fun (g : String → Bool) (f : Nat → String) (x : Nat) => g (f x)
#check fun (α β γ : Type) (g : β → γ ) (f : α → β) (x : α ) => g (f x)
def double (x : Nat) : Nat := x + x 
#eval double 10
#eval double 3
def phuckMasster : Nat → Nat := λ x =>  x + x
#check phuckMasster
#eval phuckMasster 6
def greater (x y : Nat) :=
  if x > y then x
  else y

def doTwice (f : Nat → Nat) (x : Nat) : Nat :=
  f (f x)

#check doTwice

-- composition; book is subtly wrong here
-- namely, not just *any* two functions
/-
(the codomain and domain must match)
-/
/-
def compose (α β γ : Type) (g : β → γ) (f : α → β) (x : α) : γ :=
  g (f x)
#check compose
-/
/-
Why does it look weird still?
-/



def square (x : Nat) : Nat :=
  x * x

-- what is this, does this work?
#eval compose Nat Nat Nat double square 3  -- 18
-- it looks like a comment can end it

/- Local Defs-/
#check let y := 2 + 2; y * y
#eval let y := 2 + 2; y * y
-- no "in", here
def twice_double (x : Nat) : Nat :=
  let y := x + x; y * y

#eval twice_double 2

-- now it is satisfied, for some reason...
def tee (x : Nat) : Nat :=
  let y := x + x
  y * y
#eval tee 2

def foo := let a := Nat; fun x : a => x + 2
#check foo
-- def bar := (fun a => fun x : a => x + 2) Nat

/-
in the second definition (x : a) might not make any sense
-/
/-
def dooTwice (α : Type) (f : α → α) (x : α) : α :=
  f (f x)
-- 
def dooThrice (α : Type) (f : α → α) (x : α) : α :=
  f (f (f x))
-- also can be done by composition
-/

variable (α β γ : Type)
def compose (f : β → γ ) (h : α → β ) : α → γ :=
  fun (x : α ) => f (h x)
#check compose
def dooTwice (f : α → α ) (x : α ) : α :=
  f (f x)
def dooThrice (h : α → α ) (x : α ) : α :=
  h (h (h x))
#check dooTwice
#check dooTwice

