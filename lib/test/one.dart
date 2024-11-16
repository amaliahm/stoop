// First, let's create the verification state and events
abstract class VerificationEvent {}

class CodeChanged extends VerificationEvent {
  final String code;
  CodeChanged(this.code);
}

class VerifyCode extends VerificationEvent {}

class ResendCode extends VerificationEvent {}

abstract class VerificationState {}

class VerificationInitial extends VerificationState {}
class VerificationLoading extends VerificationState {}
class VerificationSuccess extends VerificationState {}
class VerificationError extends VerificationState {
  final String message;
  VerificationError(this.message);
}

// BLoC implementation
class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final int codeLength = 4;
  String currentCode = '';
  Timer? resendTimer;
  int resendSeconds = 50;

  VerificationBloc() : super(VerificationInitial()) {
    on<CodeChanged>(_onCodeChanged);
    on<VerifyCode>(_onVerifyCode);
    on<ResendCode>(_onResendCode);
  }

  void _onCodeChanged(CodeChanged event, Emitter<VerificationState> emit) {
    currentCode = event.code;
  }

  Future<void> _onVerifyCode(VerifyCode event, Emitter<VerificationState> emit) async {
    if (currentCode.length != codeLength) {
      emit(VerificationError('Please enter complete code'));
      return;
    }

    emit(VerificationLoading());
    try {
      // Simulating API call
      await Future.delayed(Duration(seconds: 1));
      emit(VerificationSuccess());
    } catch (e) {
      emit(VerificationError(e.toString()));
    }
  }

  Future<void> _onResendCode(ResendCode event, Emitter<VerificationState> emit) async {
    resendTimer?.cancel();
    resendSeconds = 50;
    // Implement resend logic here
  }
}

// Reusable code input widget
class CodeInputField extends StatelessWidget {
  final String value;
  final Function(String) onChanged;

  const CodeInputField({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          4,
          (index) => Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              index < value.length ? value[index] : '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

// Main verification screen
class VerificationScreen extends StatelessWidget {
  final String email;

  const VerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerificationBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocConsumer<VerificationBloc, VerificationState>(
          listener: (context, state) {
            if (state is VerificationSuccess) {
              // Handle success
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Verification successful!')),
              );
            }
            if (state is VerificationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 32),
                    Text(
                      'Verification',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'We have sent a code to your email\n$email',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 32),
                    CodeInputField(
                      value: context.read<VerificationBloc>().currentCode,
                      onChanged: (value) {
                        context.read<VerificationBloc>().add(CodeChanged(value));
                      },
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: state is VerificationLoading
                          ? null
                          : () {
                              context.read<VerificationBloc>().add(VerifyCode());
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'VERIFY',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
