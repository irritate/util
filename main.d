import Core.Logger;

int main(string[] args)
{
    for (auto i = 0; i < args.length; ++i)
    {
        INFO("Arg %s: %s", i, args[i]);
    }

    return 0;
}
