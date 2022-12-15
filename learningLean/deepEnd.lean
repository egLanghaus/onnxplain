-- picking up a bit before
-- where we left off






def cons (α : Type) (a : α ) (as : List α ) : List α :=
  List.cons a as

#check cons Nat
#check cons Bool
#check cons

-- what are all these extra symbols?
#check @List.cons
#check @List.nil
#check @List.length
#check @List.append

universe u v
def f (α : Type u) (β : α → Type v) (a : α ) (b : β a) 
  : (a : α ) × β a :=
  ⟨a, b⟩
-- alternative definition:
def g (α : Type u) (β : α → Type v) (a : α ) (b : β a)
  : Σ a : α, β a :=
  Sigma.mk a b
#check Sigma.mk 

def h1 (x : Nat) : Nat :=
  (f Type (fun y => y) Nat x).2

#eval h1 5

def h2 (x : Nat) : Nat := 
  (g Type (fun α => α ) Nat x).2

#eval h2 5

def h3 (x : Nat) :=
  (f Type (fun y => y) Nat x)
#check h3
-- #eval h3 5
-- what is going on with h3

-- implicit arguments
def ident {α : Type u} (x : α) := x

#check ident         -- ?m → ?m
#check ident 1       -- Nat
#check ident "hello" -- String
#check @ident        -- {α : Type u_1} → α → α

#check @id Nat 10
-- #check @id 10
-- error as you'd expect