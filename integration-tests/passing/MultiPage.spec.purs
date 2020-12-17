module Spec where

import Quickstrom
import Data.Maybe (Maybe(..), isJust, isNothing)
import Data.Tuple (Tuple(..))
import Data.String (trim)

readyWhen :: String
readyWhen = "body"

actions :: Actions
actions =
  clicks
    <> [ Tuple 5 (Single $ Focus "input[type=text]") ]
    <> [ Tuple 5 (Single $ KeyPress ' '), Tuple 5 (Single $ KeyPress 'a') ]

proposition :: Boolean
proposition =
  let
    initial = isJust formMessage

    enterMessage = formMessage /= next formMessage

    submitInvalidMessage =
      (trim <$> formMessage) == Just "" && next (isNothing submittedMessage)

    submitValidMessage =
      (trim <$> formMessage) /= Just "" 
        && formMessage == next submittedMessage
        && isNothing submittedMessage
        && next (isNothing formMessage)
  in
    initial && always (enterMessage || submitInvalidMessage || submitValidMessage)

formMessage :: Maybe String
formMessage = map _.value (queryOne "input[type=text]" { value })

submittedMessage :: Maybe String
submittedMessage =  do
  { textContent, display } <- queryOne "#message" { textContent, display: cssValue "display" }
  if display == "none" then Nothing else Just textContent
