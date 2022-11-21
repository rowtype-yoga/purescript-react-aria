import {
  useModal,
  useOverlay,
  useOverlayPosition,
  useOverlayTrigger,
  usePreventScroll,
  OverlayProvider,
  OverlayContainer,
  DismissButton,
  ModalProvider
} from "@react-aria/overlays"

export const useModalImpl = useModal
export const useOverlayImpl = useOverlay
export const useOverlayPositionImpl = useOverlayPosition
export const useOverlayTriggerImpl = useOverlayTrigger
export const usePreventScrollImpl = usePreventScroll
export const overlayProvider = OverlayProvider
export const overlayContainer = OverlayContainer
export const dismissButton = DismissButton
export const modalProvider = ModalProvider

export function toPSAria(obj) {
  let result = {}
  Object.keys(obj).forEach((k) => {
    if (k.startsWith("aria-")) {
      const v = obj[k]
      if (v !== undefined && v !== null) {
        const newKey = k.substring(5)
        result[newKey] = v
      }
    } else {
      console.error(`${k} is not an aria attribute`)
    }
  })
  return result
}
