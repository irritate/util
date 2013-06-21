module Logger;

import std.stdio;
import std.datetime;
import std.string;
import std.conv;

enum LogLevels
{
    ERROR,
    WARNING,
    INFO,
    DEBUG
};

mixin DefineLoggers;
enum DefaultLoggingLevel = LogLevels.DEBUG;

private bool IsLoggingEnabled(LogLevels level)() { return level <= DefaultLoggingLevel ? true : false; } 

mixin template DefineLoggers()
{
    mixin DefineLoggers!(EnumMembers!LogLevels);
}

mixin template DefineLoggers(T...)
{
    mixin(DefineLogger!(to!string(T[0])));
    static if (T.length > 1)
    {
        mixin DefineLoggers!(T[1..$]);
    }
}

template DefineLogger(string level)
{
    const char[] DefineLogger = 
        "void " ~ level ~ "(T, A...)(T t, A a)
        {
            static if (IsLoggingEnabled!(LogLevels." ~ level ~ `))
            {
                auto prefix = format("[` ~ level ~ `][%s]\t%s", Clock.currTime.opCast!(TimeOfDay).toString(), t);
                writefln(prefix, a);
            }
        }`;
}

unittest
{
    ERROR("Hello");
    INFO("Hello %s", "World");
    WARNING("Hello %s", 1);
}
