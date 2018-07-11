Code | Command | Error Text | Meaning
-- | -- | -- | --
`0` | Success | Success. | Success.
`19` | Cancel | Verification requests can't be cancelled within the first 30 seconds. | You must wait at least 30s after sending a Verify Request before cancelling.
`19` | Cancel | Verification requests can't be cancelled now. Too many attempts to re-deliver have already been made. | Verify has made too many attempts to redeliver a PIN for this request; you have to wait for the workflow to complete. Also, you cannot initiate a new Verify Request until this one expires.
`19` | Trigger_Next_Event | No more events are left to execute | All the attempts to deliver the PIN for this request have been completed and there are no more events to skip to.
