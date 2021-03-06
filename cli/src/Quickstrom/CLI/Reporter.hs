{-# LANGUAGE MultiParamTypeClasses #-}

module Quickstrom.CLI.Reporter where

import Data.Text.Prettyprint.Doc (Doc)
import Prettyprinter.Render.Terminal (AnsiStyle)
import qualified Quickstrom.Run as Quickstrom
import qualified Quickstrom.WebDriver.Class as Quickstrom

data PreCheckResult = OK | CannotBeInvoked (Doc AnsiStyle)

data Reporter m = Reporter
  { preCheck :: Quickstrom.WebDriverOptions -> Quickstrom.CheckOptions -> m PreCheckResult,
    report :: Quickstrom.WebDriverOptions -> Quickstrom.CheckOptions -> Quickstrom.CheckResult -> m ()
  }
