module React.Aria.Utils where

import Foreign (Foreign, unsafeFromForeign, unsafeToForeign)
import Prim.Row (class Union)
import React.Basic.Hooks (Hook, unsafeHook)
import Effect (Effect)

foreign import useIdImpl ∷ Effect String

newtype UseId a = UseId a

useId ∷ Hook UseId String
useId = unsafeHook useIdImpl

foreign import mergePropsImpl ∷ Array Foreign → Foreign

mergeProps ∷ ∀ r1 r2 r3. Union r1 r2 r3 ⇒ { | r1 } → { | r2 } → { | r3 }
mergeProps r1 r2 = unsafeFromForeign
  (mergePropsImpl [ unsafeToForeign r1, unsafeToForeign r2 ])
