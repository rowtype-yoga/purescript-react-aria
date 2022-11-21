module React.Aria.JSSet where

import Prelude

import Data.Set (Set)
import Data.Set as Set

foreign import data JSSet ∷ Type → Type

foreign import toArray ∷ JSSet ~> Array
foreign import fromArray ∷ Array ~> JSSet

fromJSSet ∷ ∀ a. Ord a ⇒ JSSet a → Set a
fromJSSet = toArray >>> Set.fromFoldable

toJSSet ∷ Set ~> JSSet
toJSSet = Set.toUnfoldable >>> fromArray 