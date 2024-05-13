part of '../mqtt_view.dart';

class BottomMessageBar extends StatelessWidget {
  const BottomMessageBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final void Function() onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: AppColors.whiteColor,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.grey[600]!,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      onSubmitted: (value) {
                        onSend();
                      },
                      style: const TextStyle(fontSize: 13),
                      controller: controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter message',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onSend,
                    child: Icon(
                      Icons.send,
                      size: 22,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
