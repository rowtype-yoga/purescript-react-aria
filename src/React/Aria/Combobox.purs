module React.Aria.Combobox where

import Prelude

import Data.Nullable (Nullable)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn2)
import Prim.Row (class Union)
import React.Aria.JSSet (JSSet)
import React.Aria.Types (FocusStrategy, MenuTriggerAction, Selection, SelectionBehaviour, SelectionMode, ValidationState)
import React.Basic (JSX)
import React.Basic.Events (EventHandler, SyntheticEvent)
import React.Basic.Hooks (Hook, Ref, unsafeHook)
import Web.DOM (Node)

-- UseComboBox
newtype UseComboBox hooks = UseComboBox hooks

type AriaComboBoxPropsRequired a r =
  ( inputRef ∷ Ref (Nullable Node)
  , popoverRef ∷ Ref (Nullable Node)
  , listBoxRef ∷ Ref (Nullable Node)
  , children ∷ a → JSX -- Must map to either an item or a section
  | r
  )

type AriaComboBoxPropsOptional a =
  ( buttonRef ∷ Ref (Nullable Node)
  , defaultItems ∷ Array a
  , items ∷ Array a
  -- , keyboardDelegate :: KeyboardDelegate
  , onOpenChange ∷
      EffectFn2 Boolean {- isOpen -} 
        String {- menuTriggerAction: 'focus' | 'input' | 'manual' -}
        Unit
  , inputValue ∷ String
  , defaultInputValue ∷ String
  , onInputChange ∷ EffectFn1 String Unit
  , allowsCustomValue ∷ Boolean
  , menuTrigger ∷ MenuTriggerAction
  , shouldFocusWrap ∷ Boolean -- | Whether keyboard navigation is circular.
  , disabledKeys ∷
      Array String -- | The item keys that are disabled. These items cannot be selected, focused, or otherwise interacted with.
  , disallowEmptySelection ∷ Boolean -- | Whether the collection allows empty selection.
  , selectedKey ∷ String -- | The currently selected key in the collection (controlled).
  , defaultSelectedKey ∷ String -- | The initial selected key in the collection (uncontrolled).
  , onSelectionChange ∷ EffectFn1 String Unit
  , isDisabled ∷ Boolean
  , isReadOnly ∷ Boolean
  , placeholder ∷ String
  , id ∷ String
  , validationState ∷ ValidationState
  , isRequired ∷ Boolean
  , autoFocus ∷ Boolean
  , onFocus ∷ EventHandler
  , onBlur ∷ EventHandler
  , onFocusChange ∷ EffectFn1 Boolean Unit
  , onKeyDown ∷ EventHandler
  , onKeyUp ∷ EventHandler
  , label ∷ JSX
  , description ∷ JSX
  , errorMessage ∷ JSX
  )

type UseComboBoxState =
  { inputValue ∷ String
  , isFocused ∷ Boolean
  , selectedKey ∷ String
  , selectedItem ∷ Node
  , collection ∷ Array Node
  , disabledKeys :: JSSet String
  , selectionManager :: SelectionManager
  , focusStrategy ∷ FocusStrategy
  , isOpen ∷ Boolean
  , setInputValue ∷ EffectFn1 String Unit
  , commit ∷ Effect Unit
  , open ∷ EffectFn2 (Nullable FocusStrategy) MenuTriggerAction Unit
  , toggle ∷ EffectFn2 (Nullable FocusStrategy) MenuTriggerAction Unit
  , revert ∷ Effect Unit
  , setFocused ∷ EffectFn1 Boolean Unit
  , setSelectedKey ∷ EffectFn1 String Unit
  , close ∷ Effect Unit
  }

type SelectionManager =
  { selectionMode ∷ SelectionMode
  , disallowEmptySelection ∷ Boolean
  , selectionBehavior ∷ SelectionBehaviour
  , isFocused ∷ Boolean
  , focusedKey ∷ String
  , childFocusStrategy ∷ FocusStrategy
  , selectedKeys :: JSSet String
  , rawSelection :: Selection
  , isEmpty ∷ Boolean
  , isSelectAll ∷ Boolean
  , firstSelectedKey ∷ Nullable String
  , lastSelectedKey ∷ Nullable String
  , setSelectionBehavior ∷ EffectFn1 SelectionBehaviour Unit
  , setFocused ∷ EffectFn1 Boolean Unit
  , setFocusedKey ∷ EffectFn2 String FocusStrategy Unit
  , isSelected ∷ EffectFn1 String Boolean
  , extendSelection ∷ EffectFn1 String Unit
  , toggleSelection ∷ EffectFn1 String Unit
  , replaceSelection ∷ EffectFn1 String Unit
  , setSelectedKeys ∷ EffectFn1 (Array String) Unit
  , selectAll ∷ Effect Unit
  , clearSelection ∷ Effect Unit
  , toggleSelectAll ∷ Effect Unit
  , select ∷ EffectFn2 String SyntheticEvent Unit
  , isSelectionEqual :: EffectFn1 (JSSet String) Unit
  , canSelectItem ∷ EffectFn1 String Unit
  }

type ComboBoxAria = { comboBoxProps ∷ { "data-isComboBox" ∷ Boolean } }

foreign import useComboBoxImpl
  ∷ ∀ props state
  . EffectFn2 props state ComboBoxAria

useComboBox
  ∷ ∀ a props props_
  . Union props props_ (AriaComboBoxPropsOptional a)
  ⇒ { | AriaComboBoxPropsRequired a props }
  → UseComboBoxState
  → Hook UseComboBox ComboBoxAria
useComboBox p s = unsafeHook do
  runEffectFn2 useComboBoxImpl p s
