import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/features/contact/view/contact_view.dart';
import 'package:flutter_contacts_app/features/profile/view/profile_view.dart';
import 'package:flutter_contacts_app/styles/media.dart';

class NavBarModel {
  final String? imageActive;
  final String? imageInactive;
  final String? label;
  final Widget page;

  NavBarModel({
    this.imageActive,
    this.imageInactive,
    this.label,
    required this.page,
  }) : assert(imageActive != null || imageInactive != null,
            'At least one of them must not be empty.');
}

List<NavBarModel> menus = [
  NavBarModel(
    page: const ContactView(),
    label: 'Home',
    imageActive: Media.contactActive,
    imageInactive: Media.contactInactive,
  ),
  NavBarModel(
    page: const ProfileView(),
    label: 'Profile',
    imageActive: Media.profileActive,
    imageInactive: Media.profileInactive,
  ),
];
