module React.Aria.Focus where

import Prelude
import Effect.Uncurried (EffectFn1, runEffectFn1)
import React.Basic (ReactComponent)
import React.Basic.Events (EventHandler)
import React.Basic.Hooks (Hook, unsafeHook)

foreign import focusRingImpl ∷ ∀ props. ReactComponent { | props }

foreign import focusScopeImpl ∷ ∀ props. ReactComponent { | props }

foreign import useFocusRingImpl ∷ EffectFn1 UseFocusRingInput UseFocusRingResult

foreign import data UseFocusRing ∷ Type -> Type

type UseFocusRingResult =
  { isFocused ∷ Boolean
  , isFocusVisible ∷ Boolean
  , focusProps ∷ { onBlur ∷ EventHandler, onFocus ∷ EventHandler }
  }

type UseFocusRingInput =
  { within ∷ Boolean, isTextInput ∷ Boolean, autoFocus ∷ Boolean }

useFocusRing ∷ UseFocusRingInput -> Hook UseFocusRing UseFocusRingResult
useFocusRing = unsafeHook <<< runEffectFn1 useFocusRingImpl
