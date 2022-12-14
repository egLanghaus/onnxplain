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

/-
def doTwice (f : Nat → Nat) (x : Nat) : Nat :=
  f (f x)

#check doTwice
-/

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

-- here is one way to do variables:
/-
variable (α β γ : Type)
def compose (f : β → γ ) (h : α → β ) : α → γ :=
  fun (x : α ) => f (h x)
#check compose
def dooTwice (f : α → α ) (x : α ) : α :=
  f (f x)
def dooThrice (h : α → α ) (x : α ) : α :=
  h (h (h x))
#check dooTwice
#check dooThrice
def anotherTwice (h : α → α ) := compose α α α h h
#check (anotherTwice, dooTwice)
-/
-- here is another way to do variables
section useful -- namespace here enables same thing (with the types)
  variable (α β γ : Type)
  variable (f : β → γ ) (g : α → β ) (h : α → α)
  variable (x : α )
  def compose := f (g x)
  def doTwice := h (h x)
  def doThrice := h (h (h x))
  #check compose
  #check doTwice
  #check doThrice
  
  #print compose
  #print doTwice
  #print doThrice
end useful

-- now some namespaces
namespace Foo
  def a : Nat := 5
  def eff (x : Nat) : Nat := x + 7

  def fa : Nat := eff a
  def ffa : Nat := eff (eff a)

  #check a
  #check eff
  #check fa
  #check ffa
  #check Foo.fa
end Foo

-- #check a  -- error
-- #check f  -- error
#check Foo.a
#check Foo.eff
#check Foo.fa
#check Foo.ffa

section
open Foo

#check a
#check eff
#check fa
#check Foo.fa
#check Bool
end

namespace forst
def raining : Bool := true
#check raining
#eval raining
#eval ¬ raining
end forst
--#check raining -- error

section blaster
open forst
#check raining
end blaster

#check forst.raining
-- #check blaster.raining -- error!
-- sections don't support the dot, big diff

#check List.nil
#check List.cons 
#check List.map 

-- namespaces again
namespace ooF
  def a : Nat := 5
  def f (x : Nat) : Nat := x + 7

  def fa : Nat := f a

  namespace Bar
    def ffa : Nat := f (f a)

    #check fa
    #check ffa
  end Bar

  #check fa
  #check Bar.ffa
end ooF 

#check ooF.fa
#check ooF.Bar.ffa

section
open ooF

#check fa
#check Bar.ffa
end

-- how to open a namespace from another file?

-- what do you mean *dependent* type???
def cons (α : Type) (a : α) (as : List α) : List α :=
  List.cons a as

#check cons Nat        -- Nat → List Nat → List Nat
#check cons Bool       -- Bool → List Bool → List Bool
#check cons            -- (α : Type) → α → List α → List α
-- first dependent type we have seen?
-- here, types of later arguments depend on value of the first
-- can later types depend on simple values such as 1 or 2?
-- can later types depend on type of first argument?
-- how do I use type_of???
-- anyway, big important takeaway:
-- "the type of the output of f depends on its input"

#check @List.cons
#check @List.nil
#check @List.length
#check @List.append

