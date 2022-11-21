module React.Aria.Listbox where

import Prelude

import Data.Nullable (Nullable)
import Effect.Uncurried (EffectFn1, EffectFn3, runEffectFn3)
import Prim.Row (class Union)
import React.Aria.Combobox (SelectionManager)
import React.Aria.JSSet (JSSet)
import React.Aria.Types (FocusStrategy, Selection, SelectionMode)
import React.Basic (JSX, Ref)
import React.Basic.Events (EventHandler)
import React.Basic.Hooks (Hook, unsafeHook)
import Web.DOM (Node)

type ListState =
  { collection ∷ Array Node
  , disabledKeys ∷ JSSet String
  , selectionManager ∷ SelectionManager
  }

--##########################################################################  

type AriaListBoxOptions a =
  ( isVirtualized ∷ Boolean
  --  , keyboardDelegate :: KeyboardDelegate
  , shouldUseVirtualFocus ∷ Boolean
  , shouldSelectOnPressUp ∷ Boolean
  , shouldFocusOnHover ∷ Boolean
  , label ∷ JSX
  , autoFocus ∷ FocusStrategy
  , shouldFocusWrap ∷ Boolean
  , items ∷ Array a
  , disabledKeys ∷ Array String
  , selectionMode ∷ SelectionMode
  , disallowEmptySelection ∷ Boolean
  , selectedKeys ∷ Array String
  , defaultSelectedKeys ∷ Array String
  , onSelectionChange ∷ EffectFn1 Selection Unit
  , onFocus ∷ EventHandler
  , onBlur ∷ EventHandler
  , onFocusChange ∷ EffectFn1 Boolean Unit
  , id ∷ String
  , "aria-label" ∷ String
  , "aria-labelledby" ∷ String
  , "aria-describedby" ∷ String
  , "aria-details" ∷ String
  )

type ListBoxAria =
  { listBoxProps ∷ {}
  , labelProps ∷ {}
  }

foreign import useListBoxImpl
  ∷ ∀ props. EffectFn3 props ListState (Ref (Nullable Node)) ListBoxAria

newtype UseListBox hooks = UseListBox hooks

useListBox
  ∷ ∀ a props props_
  . Union props props_ (AriaListBoxOptions a)
  ⇒ { | props }
  → ListState
  → Ref (Nullable Node)
  → Hook UseListBox ListBoxAria
useListBox p s r = unsafeHook do
  runEffectFn3 useListBoxImpl p s r

--##########################################################################  

type AriaOptionPropsOptional = ("aria-label" ∷ String)
type AriaOptionPropsRequired r = (key ∷ String | r)
type OptionAria =
  { optionProps ∷ {}
  , labelProps ∷ {}
  , descriptionProps ∷ {}
  , isFocused ∷ Boolean
  , isSelected ∷ Boolean
  , isPressed ∷ Boolean
  , isDisabled ∷ Boolean
  }

foreign import useOptionImpl
  ∷ ∀ props. EffectFn3 props ListState (Ref (Nullable Node)) OptionAria

newtype UseOption hooks = UseOption hooks

useOption
  ∷ ∀ props props_
  . Union props props_ AriaOptionPropsOptional
  ⇒ { | AriaOptionPropsRequired props }
  → ListState
  → (Ref (Nullable Node))
  → Hook UseOption OptionAria
useOption p s r = unsafeHook do
  runEffectFn3 useOptionImpl p s r

--##########################################################################  

type AriaListBoxSectionProps = (heading :: JSX, "aria-label" :: String)
type ListBoxSectionAria =
  { itemProps ∷ {} -- [FIXME]
  , headingProps ∷ {} -- [FIXME]
  , groupProps ∷ {} -- [FIXME]
  }

foreign import useListBoxSectionImpl
  ∷ forall props
   . EffectFn1 props ListBoxSectionAria

newtype UseListBoxSection hooks = UseListBoxSection hooks