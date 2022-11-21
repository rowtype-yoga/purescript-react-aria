module React.Aria.Types where

import Prelude

import React.Aria.JSSet (JSSet)
import Unsafe.Coerce (unsafeCoerce)

-- MenuTriggerAction
foreign import data MenuTriggerAction ∷ Type

menuTriggerActionFocus ∷ MenuTriggerAction
menuTriggerActionFocus = unsafeCoerce "focus"

menuTriggerActionInput ∷ MenuTriggerAction
menuTriggerActionInput = unsafeCoerce "input"

menuTriggerActionManual ∷ MenuTriggerAction
menuTriggerActionManual = unsafeCoerce "manual"

instance Eq MenuTriggerAction where
  eq a b = ((unsafeCoerce a) ∷ String) == unsafeCoerce b

-- ValidationState
foreign import data ValidationState ∷ Type

validationStateValid ∷ ValidationState
validationStateValid = unsafeCoerce "valid"

validationStateInvalid ∷ ValidationState
validationStateInvalid = unsafeCoerce "invalid"

instance Eq ValidationState where
  eq a b = ((unsafeCoerce a) ∷ String) == unsafeCoerce b

-- FocusStrategy
foreign import data FocusStrategy ∷ Type

focusStrategyFirst ∷ FocusStrategy
focusStrategyFirst = unsafeCoerce "first"

focusStrategyLast ∷ FocusStrategy
focusStrategyLast = unsafeCoerce "last"

instance Eq FocusStrategy where
  eq a b = ((unsafeCoerce a) ∷ String) == unsafeCoerce b

-- SelectionMode
foreign import data SelectionMode ∷ Type

selectionModeNone ∷ SelectionMode
selectionModeNone = unsafeCoerce "none"

selectionModeSingle ∷ SelectionMode
selectionModeSingle = unsafeCoerce "single"

selectionModeMultiple ∷ SelectionMode
selectionModeMultiple = unsafeCoerce "multiple"

instance Eq SelectionMode where
  eq a b = ((unsafeCoerce a) ∷ String) == unsafeCoerce b

-- SelectionBehaviour
foreign import data SelectionBehaviour ∷ Type

selectionBehaviourToggle ∷ SelectionBehaviour
selectionBehaviourToggle = unsafeCoerce "toggle"

selectionBehaviourReplace ∷ SelectionBehaviour
selectionBehaviourReplace = unsafeCoerce "replace"

instance Eq SelectionBehaviour where
  eq a b = ((unsafeCoerce a) ∷ String) == unsafeCoerce b

-- Selection
foreign import data Selection ∷ Type

selectionAll ∷ Selection
selectionAll = unsafeCoerce "all"

selectionFromSet ∷ JSSet String -> SelectionBehaviour
selectionFromSet = unsafeCoerce
