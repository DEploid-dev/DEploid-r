#ifndef NDEBUG
#define dout std::cout << "   "
#else
#pragma GCC diagnostic ignored "-Wunused-value"
#define dout 0 && std::cout
#endif
