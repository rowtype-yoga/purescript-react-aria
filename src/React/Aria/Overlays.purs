module React.Aria.Overlays where

import Prelude

import Data.Nullable (Nullable)
import Effect (Effect)
import Effect.Aff.Compat (runEffectFn1)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3, runEffectFn2, runEffectFn3)
import Foreign (Foreign)
import Foreign.Object (Object)
import Prim.Row (class Union)
import React.Basic (JSX)
import React.Basic.DOM (CSS)
import React.Basic.Events (EventHandler)
import React.Basic.Hooks (Hook, ReactComponent, Ref, unsafeHook)
import Web.DOM (Node)
import Web.HTML (HTMLElement)

-- UseModal
newtype UseModal hooks = UseModal hooks

type UseModalOptions = { isDisabled :: Boolean }

type ModalAria = { modalProps :: { "data-ismodal" :: Boolean } }

foreign import useModalImpl ∷ EffectFn1 UseModalOptions ModalAria

useModal :: UseModalOptions -> Hook UseModal ModalAria
useModal = unsafeHook <<< runEffectFn1 useModalImpl

-- UseOverlay
newtype UseOverlay hooks = UseOverlay hooks

type UseOverlayProps =
  ( isOpen ∷ Boolean
  , onClose ∷ Effect Unit
  , isDismissable ∷ Boolean
  , shouldCloseOnBlur ∷ Boolean
  , isKeyboardDismissaDisabled ∷ Boolean
  , shouldCloseOnInteractOutside ∷ HTMLElement → Boolean
  )

type OverlayAria =
  { overlayProps ∷ { onKeyDown ∷ EventHandler }
  , underlayProps ∷ { onPointerDown ∷ EventHandler }
  }

foreign import useOverlayImpl
  ∷ ∀ useOverlayProps. EffectFn2 useOverlayProps (Ref (Nullable Node)) OverlayAria

useOverlay
  ∷ ∀ props props_
  . Union props props_ UseOverlayProps
  ⇒ Record props
  → Ref (Nullable Node)
  → Hook UseOverlay OverlayAria
useOverlay x y = unsafeHook $ runEffectFn2 useOverlayImpl x y

-- UseOverlayPosition
newtype UseOverlayPosition hooks = UseOverlayPosition hooks

type UseAriaPositionPropsRequired r =
  ( targetRef ∷ Ref (Nullable Node)
  , overlayRef ∷ Ref (Nullable Node)
  | r
  )

type UseAriaPositionPropsOptional =
  ( boundaryElement ∷ HTMLElement
  , scrollRef ∷ Ref (Nullable Node)
  , shouldUpdatePosition ∷ Boolean
  , onClose ∷ Effect Unit
  , placement ∷ String
  , containerPadding ∷ Number
  , offset ∷ Number
  , crossOffset ∷ Number
  , shouldFlip ∷ Boolean
  , isOpen ∷ Boolean
  )

type PositionAria =
  { overlayProps :: { style :: CSS }
  , arrowProps :: { style :: CSS }
  , placement :: String
  , updatePosition :: Effect Unit
  }

foreign import useOverlayPositionImpl
  ∷ ∀ props
  . EffectFn1 props PositionAria

usePosition
  ∷ ∀ props props_
  . Union props props_ UseAriaPositionPropsOptional
  ⇒ Record (UseAriaPositionPropsRequired props)
  → Hook UseOverlayPosition PositionAria
usePosition = unsafeHook <<< runEffectFn1 useOverlayPositionImpl

-- UseOverlayTrigger
newtype UseOverlayTrigger hooks = UseOverlayTrigger hooks

-- | Type must be one of the following
-- | 'dialog'
-- | 'menu'
-- | 'listbox'
-- | 'tree'
-- | 'grid'
type UseOverlayTriggerProps = { type ∷ String }

type UseOverlayTriggerState =
  { isOpen ∷ Boolean
  , open ∷ Effect Unit
  , close ∷ Effect Unit
  , toggle ∷ Effect Unit
  }

type OverlayTriggerAriaImpl =
  { triggerProps ∷ Object Foreign
  , overlayProps ∷ { id ∷ String }
  }

type OverlayTriggerAria =
  { triggerProps ∷ { _aria ∷ Object String }
  , overlayProps ∷ { id ∷ String }
  }

foreign import useOverlayTriggerImpl ∷
  EffectFn3
    UseOverlayTriggerProps
    UseOverlayTriggerState
    (Ref (Nullable Node))
    OverlayTriggerAriaImpl

useOverlayTrigger
  ∷ UseOverlayTriggerProps
  → UseOverlayTriggerState
  → Ref (Nullable Node)
  → Hook UseOverlayTrigger OverlayTriggerAria
useOverlayTrigger x y z = unsafeHook do
  implProps ← runEffectFn3 useOverlayTriggerImpl x y z
  pure (implProps { triggerProps = { _aria: toPSAria implProps.triggerProps } })

-- Prevent Scroll
newtype UsePreventScroll hooks = UsePreventScroll hooks
type UsePreventScrollOptions = { isDisabled :: Boolean }

foreign import usePreventScrollImpl ∷ EffectFn1 UsePreventScrollOptions Unit

usePreventScroll :: UsePreventScrollOptions -> Hook UsePreventScroll Unit
usePreventScroll = unsafeHook <<< runEffectFn1 usePreventScrollImpl

-- foreign import ariaHideOutsideImpl ∷ Fn2 Foreign Foreign (Effect Unit)

foreign import overlayProvider :: ReactComponent { children :: Array JSX }
foreign import overlayContainer :: ReactComponent { children :: Array JSX }
foreign import dismissButton :: ReactComponent { onDismiss :: Effect Unit }
foreign import modalProvider :: ReactComponent { children :: Array JSX }

foreign import toPSAria ∷ Object Foreign → Object String