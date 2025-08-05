import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isSigningInWithGoogle = false;
  bool _isSigningInWithApple = false;
  final AuthService _authService = AuthService();

  Future<void> _handleGoogleSignIn() async {
    if (_isSigningInWithGoogle) return;

    setState(() {
      _isSigningInWithGoogle = true;
    });

    try {
      await _authService.signInWithGoogle();

      // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      // Handle authentication result
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing in with Google: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSigningInWithGoogle = false;
        });
      }
    }
  }

  Future<void> _handleAppleSignIn() async {
    if (_isSigningInWithApple) return;

    setState(() {
      _isSigningInWithApple = true;
    });

    try {
      // TODO: Implement Apple Sign In
      await Future.delayed(
          const Duration(seconds: 2)); // Simulating network request
      // final credential = await SignInWithApple.getAppleIDCredential(
      //   scopes: [
      //     AppleIDAuthorizationScopes.email,
      //     AppleIDAuthorizationScopes.fullName,
      //   ],
      // );
      // Handle authentication result
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing in with Apple: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSigningInWithApple = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final credential = await _authService.signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text,
        );

        // Check email verification
        if (credential.user != null && !credential.user!.emailVerified) {
          // Sign out but keep the user object for resending verification
          final user = credential.user;
          await FirebaseAuth.instance.signOut();

          if (mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                bool isResending = false;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: const Text('Email Not Verified'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Please verify your email (${user?.email}) to continue.',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '1. Check your email for the verification link\n'
                            '2. Click the link to verify your email\n'
                            '3. Then click "Check Verification Status" below',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                  onPressed: isResending
                                      ? null
                                      : () async {
                                          setState(() => isResending = true);
                                          try {
                                            await _authService
                                                .sendEmailVerification(
                                                    user: user);
                                            if (mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Verification email sent! Please check your inbox.'),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            }
                                          } catch (e) {
                                            if (mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(e
                                                          is FirebaseAuthException
                                                      ? e.message ??
                                                          'Error sending verification email'
                                                      : 'Error sending verification email'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          } finally {
                                            setState(() => isResending = false);
                                          }
                                        },
                                  child: isResending
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text('Resend Verification Email'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Check Verification Status'),
                          onPressed: () async {
                            try {
                              // Try to sign in again to check verification status
                              final newCredential =
                                  await _authService.signInWithEmailAndPassword(
                                _emailController.text.trim(),
                                _passwordController.text,
                              );

                              if (newCredential.user?.emailVerified == true) {
                                if (mounted) {
                                  Navigator.of(context).pop(); // Close dialog
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                }
                              } else {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Email is not verified yet. Please check your email and click the verification link.'),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Error checking verification status. Please try again.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
            return;
          }
        }

        if (credential.user != null && credential.user!.emailVerified) {
          // Successfully signed in and email is verified
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        }
      } on FirebaseAuthException catch (e) {
        String message;
        Color backgroundColor = Colors.red.shade700;

        switch (e.code) {
          case 'user-not-found':
            message =
                '🚫 Account not found. Create a new account to get started!';
            backgroundColor = Colors.orange.shade700;
          case 'wrong-password':
            message = '🔐 Incorrect password';
          case 'invalid-email':
            message = '📧 Invalid email format';
          case 'too-many-requests':
            message =
                '⚠️ Access temporarily disabled due to many failed attempts. '
                'Please try again after a few minutes or reset your password.';
            backgroundColor = Colors.orange.shade800;
            // Show a dialog with more detailed information
            if (mounted) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Too Many Failed Attempts'),
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Your account has been temporarily disabled due to too many failed login attempts.'),
                        SizedBox(height: 16),
                        Text('You can:'),
                        SizedBox(height: 8),
                        Text('• Wait a few minutes and try again'),
                        Text('• Reset your password'),
                        Text('• Contact support if the issue persists'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Reset Password'),
                        onPressed: () {
                          // TODO: Implement password reset
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          default:
            message = 'Authentication failed';
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              backgroundColor: backgroundColor,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
              action: e.code == 'user-not-found'
                  ? SnackBarAction(
                      label: 'Sign Up',
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/get-started');
                      },
                    )
                  : null,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Image.asset(
                    'images/elimtrust.png',
                    height: 100,
                    //   color: Colors.blue.shade700,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade400)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade400)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed:
                            _isSigningInWithGoogle ? null : _handleGoogleSignIn,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: _isSigningInWithGoogle
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.blue.shade700,
                                ),
                              )
                            : Image.asset(
                                'images/google.png',
                                height: 24,
                                width: 24,
                              ),
                        label: const Text('Google'),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton.icon(
                        onPressed:
                            _isSigningInWithApple ? null : _handleAppleSignIn,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: _isSigningInWithApple
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.black,
                                ),
                              )
                            : Image.asset(
                                'images/apple-logo.png',
                                height: 24,
                                width: 24,
                              ),
                        label: const Text('Apple'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.blue.shade700),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/get-started');
                        },
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
