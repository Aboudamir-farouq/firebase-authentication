import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.isLoading = false,
    required this.textButton,
    required this.onPressed
  });

  final bool isLoading; 
  final String textButton;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: isLoading 
              ? const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
              : Text(
                textButton,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
              ),
          )
        ),
      ),
    );
  }
}