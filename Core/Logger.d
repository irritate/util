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

static LogLevels DefaultLoggingLevel = LogLevels.DEBUG;
private bool IsLoggingEnabled(LogLevels level) { return level <= DefaultLoggingLevel ? true : false; }  

//! Try to get rid of our boilerplate code with this
mixin template InternalLogger(alias level)
{
    void func(T, A...)(T t, A a)
    {
        if (IsLoggingEnabled(level))
        {
            auto prefix = format("[%s][%s]\t%s", to!string(level), Clock.currTime.opCast!(TimeOfDay).toString(), t);
            writefln(prefix, a);
        }
    }
}

mixin InternalLogger!(LogLevels.ERROR) Error;
alias Error.func ERROR;

mixin InternalLogger!(LogLevels.WARNING) Warning;
alias Warning.func WARNING;

mixin InternalLogger!(LogLevels.INFO) Info;
alias Info.func INFO;

mixin InternalLogger!(LogLevels.DEBUG) Debug;
alias Debug.func DEBUG;

unittest
{
    ERROR("Hello");
    INFO("Hello %s", "World");
    WARNING("Hello %s", 1);
}
