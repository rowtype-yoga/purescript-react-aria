module React.Aria.Button
  ( useButton
  , UseButton
  , ButtonPropsImpl
  , pressEvent
  , PressEventImpl
  ) where

import Prelude
import Data.Nullable (Nullable)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn2)
import Foreign (Foreign, unsafeFromForeign, unsafeToForeign)
import Foreign.Object (Object)
import Prim.Row (class Union)
import React.Basic.Events (EventFn, SyntheticEvent, EventHandler, unsafeEventFn)
import React.Basic.Hooks (Hook, Ref, unsafeHook)
import Unsafe.Coerce (unsafeCoerce)
import Untagged.Union (OneOf)
import Web.DOM (Node)
import Web.HTML (HTMLElement)

foreign import data UseButton ∷ Type → Type

type PressEventImpl =
  { type ∷ String
  , pointerType ∷ String
  , target ∷ HTMLElement
  , shiftKey ∷ Boolean
  , ctrlKey ∷ Boolean
  , metaKey ∷ Boolean
  }

pressEvent ∷ EventFn SyntheticEvent PressEventImpl
pressEvent = unsafeEventFn unsafeCoerce

type ButtonPropsImpl =
  ( elementType ∷ String -- button/a/div...
  , isDisabled ∷ Boolean
  , onPress ∷ EventHandler
  , onPressStart ∷ EventHandler
  , onPressEnd ∷ EventHandler
  , onPressUp ∷ EventHandler
  , onPressChange ∷ EffectFn1 Boolean Unit
  , preventFocusOnPress ∷ Boolean
  , href ∷ String -- for `a`
  , target ∷ String -- for `a`
  , rel ∷ String -- for `a`
  , "aria-expanded" ∷ Boolean
  , "aria-haspopup" ∷ OneOf Boolean String
  , "aria-controls" ∷ String
  , "aria-pressed" ∷ Boolean
  , type ∷ String -- button/submit/reset
  , excludeFromTabOrder ∷ Boolean
  , "aria-label" ∷ String
  , "aria-labelledby" ∷ String
  , "aria-describedby" ∷ String
  , "aria-details" ∷ String
  )

type ButtonPropsResult =
  { _aria ∷ Object String
  , disabled ∷ Boolean
  , onBlur ∷ EventHandler
  , onClick ∷ EventHandler
  , onDragStart ∷ EventHandler
  , onFocus ∷ EventHandler
  , onKeyDown ∷ EventHandler
  , onKeyUp ∷ EventHandler
  , onMouseDown ∷ EventHandler
  , onPointerDown ∷ EventHandler
  , onPointerUp ∷ EventHandler
  , tabIndex ∷ Int
  , type ∷ String
  }

useButton ∷
  ∀ attrsIn attrsIn_.
  Union attrsIn attrsIn_ ButtonPropsImpl ⇒
  { | attrsIn } →
  Ref (Nullable Node) →
  Hook UseButton { isPressed ∷ Boolean, buttonProps ∷ ButtonPropsResult }
useButton props ref =
  unsafeHook
    $
      runEffectFn2 useButtonImpl
        (unsafeToForeign $ props)
        ref
        <#> (fromDashedProps >>> unsafeFromForeign)

foreign import useButtonImpl ∷
  EffectFn2
    (Foreign)
    (Ref (Nullable Node))
    (Foreign)

foreign import toDashedProps ∷ Foreign → Foreign

foreign import fromDashedProps ∷ Foreign → Foreign
