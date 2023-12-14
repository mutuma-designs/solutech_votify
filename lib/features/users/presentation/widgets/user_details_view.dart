import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_votify/utils/extensions/date_time.dart';
import 'package:solutech_votify/utils/extensions/image.dart';

import '../../../../config/images.dart';
import '../../domain/entities/user.dart';

class UserDetailsView extends StatelessWidget {
  final User user;
  const UserDetailsView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final photo = user.photo;

    return Column(
      children: [
        if (photo != null)
          CachedNetworkImage(
            imageUrl: photo.toAvatarUrl,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        if (photo == null)
          Image.asset(
            Images.userPlaceholder,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        const SizedBox(height: 16),
        Text(
          user.fullName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Unique ID: ',
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: user.uniqueId,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Email: ',
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: user.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Phone: ',
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: user.phone,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            if (user.age != null) const SizedBox(height: 8),
            if (user.age != null)
              RichText(
                text: TextSpan(
                  text: 'Age: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: [
                    TextSpan(
                      text: "${user.age} years",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Date of Birth: ',
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: user.dateOfBirth?.toFormattedStringWithMonth(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Gender: ',
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: user.gender,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Role: ',
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: user.role?.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ],
    );
  }
}
