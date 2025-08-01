import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/supplier_model.dart';

class SupplierItemCard extends StatelessWidget {
  final SupplierModel supplier;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onViewDetails;
  final VoidCallback? onDeactivate;
  final VoidCallback? onActivate;
  final bool showSelectionCheckbox;

  const SupplierItemCard({
    Key? key,
    required this.supplier,
    this.isSelected = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onViewDetails,
    this.onDeactivate,
    this.onActivate,
    this.showSelectionCheckbox = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: isSelected ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(color: Theme.of(context).primaryColor, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (showSelectionCheckbox)
                    Checkbox(
                      value: isSelected,
                      onChanged: (_) => onTap?.call(),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          supplier.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        if (supplier.contactPerson != null)
                          Text(
                            'Contact: ${supplier.contactPerson}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(context),
                ],
              ),
              SizedBox(height: 12),
              _buildContactInfo(context),
              if (_hasAddressInfo()) ...[
                SizedBox(height: 8),
                _buildAddressInfo(context),
              ],
              SizedBox(height: 12),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final color = supplier.isActive ? Colors.green : Colors.red;
    final icon = supplier.isActive ? Icons.check_circle : Icons.cancel;
    final text = supplier.isActive ? 'Active' : 'Inactive';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        if (supplier.email != null)
          InkWell(
            onTap: () => _launchEmail(supplier.email!),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.email,
                  size: 16,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 4),
                Text(
                  supplier.email!,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        if (supplier.phoneNumber != null)
          InkWell(
            onTap: () => _launchPhone(supplier.phoneNumber!),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.phone,
                  size: 16,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 4),
                Text(
                  supplier.phoneNumber!,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildAddressInfo(BuildContext context) {
    final addressParts = <String>[];
    if (supplier.address != null && supplier.address!.isNotEmpty) {
      addressParts.add(supplier.address!);
    }
    if (supplier.city != null && supplier.city!.isNotEmpty) {
      addressParts.add(supplier.city!);
    }
    if (supplier.state != null && supplier.state!.isNotEmpty) {
      addressParts.add(supplier.state!);
    }
    if (supplier.country != null && supplier.country!.isNotEmpty) {
      addressParts.add(supplier.country!);
    }
    if (supplier.postalCode != null && supplier.postalCode!.isNotEmpty) {
      addressParts.add(supplier.postalCode!);
    }

    if (addressParts.isEmpty) return SizedBox.shrink();

    return Row(
      children: [
        Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            addressParts.join(', '),
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (onEdit != null)
          TextButton.icon(
            onPressed: onEdit,
            icon: Icon(Icons.edit, size: 18),
            label: Text('Edit'),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => [
            if (onViewDetails != null)
              PopupMenuItem<String>(
                value: 'view',
                child: Row(
                  children: [
                    Icon(Icons.visibility, size: 18),
                    SizedBox(width: 8),
                    Text('View Details'),
                  ],
                ),
              ),
            if (supplier.isActive && onDeactivate != null)
              PopupMenuItem<String>(
                value: 'deactivate',
                child: Row(
                  children: [
                    Icon(Icons.block, size: 18, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('Deactivate'),
                  ],
                ),
              ),
            if (!supplier.isActive && onActivate != null)
              PopupMenuItem<String>(
                value: 'activate',
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 18, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Activate'),
                  ],
                ),
              ),
            if (onDelete != null) ...[
              PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 18, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ],
          onSelected: (value) {
            switch (value) {
              case 'view':
                onViewDetails?.call();
                break;
              case 'deactivate':
                onDeactivate?.call();
                break;
              case 'activate':
                onActivate?.call();
                break;
              case 'delete':
                onDelete?.call();
                break;
            }
          },
        ),
      ],
    );
  }

  bool _hasAddressInfo() {
    return (supplier.address != null && supplier.address!.isNotEmpty) ||
        (supplier.city != null && supplier.city!.isNotEmpty) ||
        (supplier.state != null && supplier.state!.isNotEmpty) ||
        (supplier.country != null && supplier.country!.isNotEmpty) ||
        (supplier.postalCode != null && supplier.postalCode!.isNotEmpty);
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }
}
