module React.Aria.Interactions where

import Prelude

import Effect.Uncurried (EffectFn1, runEffectFn1)
import Prim.Row (class Union)
import React.Basic.Events (EventHandler)
import React.Basic.Hooks (Hook, unsafeHook)

-- UseFocusWithin

type FocusWithinProps =
  ( isDisabled ∷ Boolean
  , onFocusWithin ∷ EventHandler
  , onBlurWithin ∷ EventHandler
  , onFocusWithinChange ∷ EffectFn1 Boolean Unit
  )

type FocusWithinResult =
  { focusWithinProps ∷
      { onBlur ∷ EventHandler, onFocus ∷ EventHandler }
  }

foreign import useFocusWithinImpl ∷ ∀ props. EffectFn1 props FocusWithinResult

newtype UseFocusWithin a = UseFocusWithin a

useFocusWithin ∷
  ∀ props props_.
  Union props props_ FocusWithinProps ⇒
  { | props } →
  Hook UseFocusWithin FocusWithinResult
useFocusWithin = unsafeHook <<< runEffectFn1 useFocusWithinImpl

-- UseFocus

type FocusProps =
  ( isDisabled ∷ Boolean
  , onFocus ∷ EventHandler
  , onBlur ∷ EventHandler
  , onFocusChange ∷ EffectFn1 Boolean Unit
  )

type FocusResult =
  { focusProps ∷ { onBlur ∷ EventHandler, onFocus ∷ EventHandler } }

foreign import useFocusImpl ∷ ∀ props. EffectFn1 props FocusResult

newtype UseFocus a = UseFocus a

useFocus ∷
  ∀ props props_.
  Union props props_ FocusProps ⇒
  { | props } →
  Hook UseFocus FocusResult
useFocus = unsafeHook <<< runEffectFn1 useFocusImpl
