import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/users/presentation/screens/user_details_screen.dart';
import 'package:solutech_votify/utils/extensions/date_time.dart';
import 'package:solutech_votify/utils/extensions/image.dart';

import '../../../../config/images.dart';
import '../../domain/entities/user.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final photo = user.photo;
    return GestureDetector(
      onTap: () => context.push(
        UserDetailsScreen.routePath,
        extra: UserDetailsScreenExtra(
          userId: user.id,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
        child: Row(
          children: [
            if (photo != null)
              CachedNetworkImage(
                imageUrl: photo.toAvatarUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            if (photo == null)
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.userPlaceholder),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (user.gender != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Gender: ${user.gender}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  if (user.dateOfBirth != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Date of Birth: ${user.dateOfBirth?.toFormattedStringWithMonth()}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  if (user.phone != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Phone: ${user.phone}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    'Email: ${user.email}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
