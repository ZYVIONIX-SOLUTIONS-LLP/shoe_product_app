import 'package:flutter/material.dart';
import 'package:rive/rive.dart' hide RadialGradient, LinearGradient;
import 'package:shoe_product/views/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  StateMachineController? _stateMachineController;
  SMIInput<bool>? _isChecking;
  SMIInput<double>? _numLook;
  SMIInput<bool>? _isHandsUp;
  SMITrigger? _trigSuccess;
  SMITrigger? _trigFail;

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(_onEmailFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);

    _emailController.addListener(_onEmailTextChange);
  }

  void _onEmailFocusChange() {
    if (_isChecking != null) {
      _isChecking!.value = _emailFocusNode.hasFocus;
    }
  }

  void _onPasswordFocusChange() {
    if (_isHandsUp != null) {
      _isHandsUp!.value = _passwordFocusNode.hasFocus;
    }
  }

  void _onEmailTextChange() {
    if (_numLook != null) {
      _numLook!.value = _emailController.text.length.toDouble() * 2.0;
    }
  }

  void _onRiveInit(Artboard artboard) {
    _stateMachineController = StateMachineController.fromArtboard(
      artboard,
      'Login Machine',
    );

    if (_stateMachineController != null) {
      artboard.addController(_stateMachineController!);

      _isChecking = _stateMachineController!.findInput<bool>('isChecking');
      _numLook = _stateMachineController!.findInput<double>('numLook');
      _isHandsUp = _stateMachineController!.findInput<bool>('isHandsUp');

      _trigSuccess =
          _stateMachineController!.findInput<bool>('trigSuccess')
              as SMITrigger?;
      _trigFail =
          _stateMachineController!.findInput<bool>('trigFail') as SMITrigger?;
    }
  }

  void _submitLogin() {
    // Hide keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    // Simulate standard mock authentication check
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;

      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // Simple mock validation rules
      if (email.isNotEmpty && password.length >= 6) {
        // SUCCESS
        _trigSuccess?.fire();

        Future.delayed(const Duration(milliseconds: 1000), () {
          if (!mounted) return;
          setState(() {
            _isLoading = false;
          });
          // Navigate to HomeScreen (fade transition)
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HomeScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
              transitionDuration: const Duration(milliseconds: 600),
            ),
          );
        });
      } else {
        // FAILURE
        _trigFail?.fire();

        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Please Enter User name and Password.'),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_onEmailFocusChange);
    _passwordFocusNode.removeListener(_onPasswordFocusChange);
    _emailController.removeListener(_onEmailTextChange);

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF171514);
    const accent = Color(0xFFFF5A1F);

    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.0, 1.2),
                  radius: 1.3,
                  colors: [Color(0x2DFF5A1F), Colors.transparent],
                ),
              ),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final height = constraints.maxHeight;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: height),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),

                          const Text(
                            'Welcome Back',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Sign in to access your custom locker',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                            ),
                          ),

                          SizedBox(
                            height: height * 0.35,
                            child: RiveAnimation.network(
                              'https://public.rive.app/community/runtime-files/2244-4463-animated-login-screen.riv',
                              fit: BoxFit.contain,
                              onInit: _onRiveInit,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.08),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Username input
                                Text(
                                  'EMAIL / USERNAME',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.03),
                                    hintText: 'Enter your email',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.3),
                                      fontSize: 14,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.alternate_email_rounded,
                                      color: Colors.white.withOpacity(0.4),
                                      size: 20,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 16,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.06),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: accent,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Password input
                                Text(
                                  'PASSWORD',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  obscureText: !_isPasswordVisible,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.03),
                                    hintText: 'Enter password',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.3),
                                      fontSize: 14,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: Colors.white.withOpacity(0.4),
                                      size: 20,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: Colors.white.withOpacity(0.4),
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 16,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.06),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: accent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),
                          const SizedBox(height: 24),

                          // Submit button
                          ElevatedButton(
                            onPressed: _isLoading ? null : _submitLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accent,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: accent.withOpacity(0.5),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 16),

                          // Bottom Sign up hint
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       "Don't have an account? ",
                          //       style: TextStyle(
                          //         color: Colors.white.withOpacity(0.6),
                          //         fontSize: 13,
                          //       ),
                          //     ),
                          //     GestureDetector(
                          //       onTap: () {},
                          //       child: const Text(
                          //         'Sign Up',
                          //         style: TextStyle(
                          //           color: accent,
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 13,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
