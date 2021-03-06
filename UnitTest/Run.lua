--===========================================================================--
--                                                                           --
--                            UnitTest For PLoop                             --
--                                                                           --
--===========================================================================--

--===========================================================================--
-- Author       :   kurapica125@outlook.com                                  --
-- URL          :   http://github.com/kurapica/PLoop                         --
-- Create Date  :   2018/09/26                                               --
-- Update Date  :   2018/09/26                                               --
-- Version      :   1.0.0                                                    --
--===========================================================================--
PLOOP_PLATFORM_SETTINGS = {
    OBJECT_NO_RAWSEST = true, OBJECT_NO_NIL_ACCESS = true,
    CORE_LOG_LEVEL = 3,
    MULTI_OS_THREAD = true, MULTI_OS_THREAD_ENV_AUTO_CACHE_WARN = false,
    TYPE_VALIDATION_DISABLED = false,
}

PLOOP_UNITTEST_MODULES      = {
    "prototype", "environment", "namespace", "enum", "struct", "class",
    "variables",
}

require "PLoop"(function(_ENV)
    require "PLoop.System.IO"
    require "PLoop.System.UnitTest"

    export {
        pcall               = pcall,
        ipairs              = ipairs,
        loadfile            = loadfile,
        Info                = Logger.Default[Logger.LogLevel.Info],
        Warn                = Logger.Default[Logger.LogLevel.Warn],
        Error               = Logger.Default[Logger.LogLevel.Error],

        System.IO.Path, UnitTest
    }

    Logger.Default:AddHandler(print)

    local root = Path.CombinePath(Path.GetCurrentPath(), "Tests")

    for _, name in ipairs(PLOOP_UNITTEST_MODULES) do
        local func, msg = loadfile(Path.CombinePath(root, name) .. ".lua")
        if not func then
            Error("[UnitTest]Failed to load test for %s - %s", name, msg)
        end
        local ok, msg = pcall(func)
        if not ok then
            Error("[UnitTest]Failed to load test for %s - %s", name, msg)
        end
    end

    UnitTest("PLoop"):Run()
end)
