import { mergeProps, useId } from "@react-aria/utils"

export function mergePropsImpl(args) {
  return mergeProps(...args)
}

export const useIdImpl = useId
