# Assets Directory

This directory contains all the static assets used in the Naam Uzhavan app.

## Structure

```
assets/
├── images/       # App images (logos, illustrations, etc.)
└── icons/        # Custom icons
```

## Adding New Assets

### Images

1. Place image files in the `images/` directory
2. Update `pubspec.yaml` to include them:
   ```yaml
   flutter:
     assets:
       - assets/images/your_image.png
   ```
3. Use in code:
   ```dart
   Image.asset('assets/images/your_image.png')
   ```

### Icons

1. Place icon files in the `icons/` directory
2. Update `pubspec.yaml` to include them
3. Use in code similar to images

## Recommended Image Formats

- **PNG**: For images with transparency
- **JPG**: For photos and images without transparency
- **SVG**: For vector graphics (requires flutter_svg package)

## Image Guidelines

### App Logo
- Recommended size: 512x512 px
- Format: PNG with transparency
- Use for splash screen and about section

### Feature Icons
- Size: 48x48 px to 128x128 px
- Format: PNG with transparency
- Use for feature cards and buttons

### Illustrations
- Size: Depends on usage
- Format: PNG or JPG
- Optimize for mobile (keep file size small)

## Optimization

Before adding images:
1. Compress images to reduce file size
2. Use appropriate resolution for mobile screens
3. Consider using multiple resolutions for different screen densities

### Tools for Optimization
- [TinyPNG](https://tinypng.com/) - PNG compression
- [ImageOptim](https://imageoptim.com/) - Multi-format optimization
- [Squoosh](https://squoosh.app/) - Online image optimizer

## Example Usage

### Adding an App Logo

1. Create or obtain logo image (512x512 px PNG)
2. Save as `assets/images/app_logo.png`
3. Update `pubspec.yaml`:
   ```yaml
   flutter:
     assets:
       - assets/images/app_logo.png
   ```
4. Use in code:
   ```dart
   Image.asset(
     'assets/images/app_logo.png',
     width: 100,
     height: 100,
   )
   ```

### Adding Custom Icons

1. Save icon as `assets/icons/custom_icon.png`
2. Update `pubspec.yaml`
3. Use in code:
   ```dart
   Image.asset(
     'assets/icons/custom_icon.png',
     width: 24,
     height: 24,
     color: Colors.white, // Optional tint
   )
   ```

## Current Assets

Currently, the app uses Material Icons for all iconography. No custom assets are included yet.

### To Add in Future

- App logo for splash screen
- Feature illustrations
- Crop type icons
- Weather icons
- Achievement badges
- Tutorial images

## Best Practices

1. **Naming Convention**: Use lowercase with underscores (e.g., `app_logo.png`)
2. **Organization**: Group related images in subdirectories
3. **Documentation**: Document the purpose of each asset
4. **Version Control**: Commit assets to git (unless very large)
5. **Licensing**: Ensure you have rights to use all assets

## Size Considerations

- Keep individual images under 500KB
- Total assets folder should ideally be under 10MB
- For large assets, consider:
  - Loading from network
  - Progressive loading
  - Lazy loading

## Related Files

- `pubspec.yaml` - Asset declarations
- `lib/core/theme/app_theme.dart` - App styling
- Asset usage examples throughout `lib/features/`

For questions about assets, refer to the [Flutter documentation](https://docs.flutter.dev/development/ui/assets-and-images).
