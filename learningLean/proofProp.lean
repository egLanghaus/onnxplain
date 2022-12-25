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

-- is the precedeing OK because Nat is famously inhabited?
-- (yeah, running with that for now)

