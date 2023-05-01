//____________________________________
// Treeform's ime extension          |
// Currently not used or compiled    |
//___________________________________|


//__________________________________________________
// input.c
GLFWAPI void glfwCloseIme(void)
{
    _glfwPlatformCloseIme();
}

//__________________________________________________
// win32_window.c
GLFWAPI void _glfwPlatformCloseIme(GLFWwindow* handle)
{
    _GLFWwindow* window = (_GLFWwindow*) handle;

    // Dump IME edit characters into text.
    WCHAR* wideEditString = _glfwCreateWideStringFromUTF8Win32(
        window->imeEditString
    );
    for (int i = 0;  i < 256;  i++)
    {
        const WCHAR codepoint = wideEditString[i];
        if ((codepoint & 0xff00) == 0xf700)
            continue;
        if (codepoint == 0)
            break;
        _glfwInputChar(window, codepoint, 0, 1);
    }
    free(wideEditString);

    // Close IME window
    HWND hWnd = window->win32.handle;
    HIMC hIMC = ImmGetContext(hWnd);
    ImmNotifyIME(hIMC, NI_COMPOSITIONSTR, CPS_CANCEL, 0);
    ImmReleaseContext(hWnd, hIMC);

    // Clear IME state.
    window->imeEditLocation = 0;
    window->imeEditString[0] = '\0';
}
//__________________________________________________
// x11_window.c
GLFWAPI void _glfwPlatformCloseIme(GLFWwindow* handle)
{
    //TODO: Implment IME on linux.
}
//__________________________________________________
// cocoa_window.m
GLFWAPI void _glfwPlatformCloseIme(GLFWwindow* handle)
{
    _GLFWwindow* window = (_GLFWwindow*) handle;

    // Dump IME edit characters into text.
    NSString* characters = [NSString
        stringWithUTF8String:window->imeEditString];
    const NSUInteger length = [characters length];
    for (NSUInteger i = 0;  i < length;  i++)
    {
        const unichar codepoint = [characters characterAtIndex:i];
        if ((codepoint & 0xff00) == 0xf700)
            continue;
        _glfwInputChar(window, codepoint, 0, 1);
    }

    // Close IME window
    NSTextInputContext* inputContext = [window->ns.view inputContext];
    [inputContext discardMarkedText];

    // Clear IME state.
    window->imeEditLocation = 0;
    window->imeEditString[0] = '\0';
}

//__________________________________________________
// window.c
GLFWAPI void glfwSetImePos(GLFWwindow* handle, int* xpos, int* ypos)
{
    _GLFWwindow* window = (_GLFWwindow*) handle;
    assert(window != NULL);

    _GLFW_REQUIRE_INIT();

    if (window->monitor)
        return;

    window->imeX = xpos;
    window->imeY = ypos;
}

GLFWAPI void glfwGetIme(GLFWwindow* handle, int* location, char* string)
{
    _GLFWwindow* window = (_GLFWwindow*) handle;
    assert(window != NULL);

    _GLFW_REQUIRE_INIT();

    if (window->monitor)
        return;

    *location = window->imeEditLocation;
    memcpy(string, window->imeEditString, 256);
}
