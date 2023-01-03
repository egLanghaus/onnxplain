/-
note that this was a 'hypothetical' discussion
and not how Lean 4 actually does it...!
I lifted the namespace below from
the only known post (at time of writing)
about "#check Implies" not computing
-/
namespace TPIL

axiom Prop' : Type
axiom And : Prop' → Prop' → Prop'
axiom Or : Prop' → Prop' → Prop'
axiom Not : Prop' → Prop'
axiom Implies : Prop' → Prop' → Prop'
axiom Proof : Prop' → Type

variable (p q r : Prop')
#check And p q                      -- Prop'
#check Or (And p q) r               -- Prop'
#check Implies (And p q) (And q p)  -- Prop'

#check Proof   -- Proof : Prop' → Type

axiom and_comm (p q : Prop') : Proof (Implies (And p q) (And q p))

variable (p q : Prop')
#check and_comm p q     -- Proof (Implies (And p q) (And q p))

axiom modus_ponens : (p q : Prop') → Proof (Implies p q) →  Proof p → Proof q

axiom implies_intro : (p q : Prop') → (Proof p → Proof q) → Proof (Implies p q)
#check Implies 
#check And
#check Or
#check Not

end TPIL

variable {p : Prop}
variable {q : Prop}
universe u

section
  variable {α : Type u}
  variable (x : α)
  def ident := x
end 

-- note difference between section and namespace
-- section is organizing definitions
-- variables are confined to the section

#check x
#check α 
#check ident
#check @ident
#check ident 4
#check ident "hello"


-- MEAT BEGINS: "Working with PaT"

variable {p : Prop}
variable {q : Prop}

theorem t1 : p → q → p := fun hp : p => fun hq : q => hp 
#check t1
#print t1

-- what if I do not give the proof, though?
opaque t4 : p → q → p

opaque seven : Nat

#check seven

-- is the preceding OK because Nat is famously inhabited?
-- (yeah, running with that for now)

-- remarks on output of print t1 confuse me
-- particularly: "since the arrow denotes nothing more than 
-- an arrow type in which the target does not depend on the bound variable."
-- if p implies q and q implies r then p implies r
section 
  variable (p q r s : Prop)
  
  theorem t2  (h₁ : q → r) (h₂ : p → q) : p → r :=
    fun h₃ : p => show r from h₁ (h₂ h₃)
end 

#check t2

#check True
#check And
#check Or 
#check Not
#check Iff
#check And.intro
#check p → q → p ∧ q
#check ¬p → p ↔ False

variable (hp : p) (hq : q)

#check And.intro hp hq

example (h : p ∧ q) : p := And.left h
example (h : p ∧ q) : q := And.right h
variable (h : p ∧ q)
-- these two are the same, yes?
-- thinking that these are the same but not sure...
example : p ∧ q → q ∧ p := fun h => And.intro (And.right h) (And.left h)
example (h : p ∧ q) : q ∧ p := And.intro (And.right h) (And.left h)

#check 4 + 4 = 9
#eval 4 + 4 = 9
-- good to know
#check (⟨hp, hq⟩ : p ∧ q)
-- hmmm
-- guessing that because angle brackets are overloaded...
-- it needs the type annotation and then it can check it
-- but why no inference? what about this...
-- #check ⟨hp : p, hq : q⟩ 
-- no, that does not work
example : q ∧ p := ⟨ h.right, h.left ⟩ 
-- example : q ∧ p := fun h => ⟨h.right,h.left⟩ 
-- (above does not work)

/-
flattening nested constructors
-/

example (h : p ∧ q) : q ∧ p ∧ q :=
  ⟨h.right, ⟨h.left, h.right⟩⟩
example (h : p ∧ q) : q ∧ p ∧ q :=
  ⟨h.right, h.left, h.right⟩

-- constructing an "or"
example : p ∨ q := Or.intro_left q hp
example : p ∨ q := Or.intro_right p hq

-- using an Or (elimination)
#check Or.elim
#check Or.intro_right

-- proving commutativity
variable (p q r : Prop)

example (h : p ∨ q) : q ∨ p :=
  Or.elim h 
    (fun hp => Or.intro_right q hp) 
    (fun hq => Or.intro_left p hq)

example (h : p ∨ q) : q ∨ p :=
  Or.elim h
    (fun hp => show q ∨ p from Or.inr hp)
    (fun hq => show q ∨ p from Or.inl hq)

/-
taking off our glasses...
elimination takes a proof of p or q
and two functions:
one that proves q or p from p
one that proves q or p from q
-/
-- this next bit makes the elimination clearer:
example (h : p ∨ q) : q ∨ p :=
  h.elim (fun hp => Or.inr hp) (fun hq => Or.inl hq)

