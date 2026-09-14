import 'package:flutter/material.dart';
class ActivityCard extends StatelessWidget{
  final String tittle;
  final String subtitle;
  final String trailingText;
  final IconData icon;
  final Color iconColor;

  const ActivityCard({
    super.key,
    required this.tittle,
    required this.subtitle,
    required this.trailingText,
    required this.icon,
    required this.iconColor,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon,size:40, color: iconColor),
        title: Text(tittle,style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(
          trailingText,
           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
           ),
      ),
    );
  }
}