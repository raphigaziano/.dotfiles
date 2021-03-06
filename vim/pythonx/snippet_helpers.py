def complete(t, opts):
    """
    Autocompletion helper, slightly tweaked from the tutorial screencast @
    https://www.youtube.com/watch?v=JJQYwt6Diro

    """
    if t:
        opts = [ m[len(t):] for m in opts if m.startswith(t) ]
    if len(opts) == 1:
        return opts[0]
    return "(" + '|'.join(opts) + ")" if opts else ''

def humanize(s):
    """ Helper to turn a python identifier into a Human readable string."""
    return s.replace('_', ' ').capitalize()
