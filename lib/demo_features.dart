import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Demo file showcasing all business-level features implemented in Revv App
class RevvBusinessFeatures {
  
  /// 🎥 Professional Camera Features
  static const List<String> cameraFeatures = [
    'Multi-resolution video recording (Low to Ultra-High)',
    'Professional grid overlay for composition',
    'Flash control (torch/off)',
    'Front/back camera switching',
    'Real-time recording timer',
    'Business mode with category selection',
    'Professional UI with dark theme',
    'Error handling and user feedback',
  ];

  /// 📱 Advanced Post Creation
  static const List<String> postFeatures = [
    'Rich media preview (images & videos)',
    'Video playback controls with progress tracking',
    'Business category selection',
    'Post scheduling capabilities',
    'Hashtag and location tagging',
    'Privacy controls (public/private)',
    'Comment moderation settings',
    'Analytics tracking toggle',
  ];

  /// 🏢 Business Dashboard
  static const List<String> businessFeatures = [
    'Analytics overview with performance metrics',
    'Content management tools',
    'Post scheduling calendar',
    'Business insights and recommendations',
    'Engagement rate tracking',
    'Follower growth analytics',
    'Content performance insights',
    'Professional post cards with metrics',
  ];

  /// 🎨 Professional UI/UX
  static const List<String> uiFeatures = [
    'Modern dark theme design',
    'Google Fonts integration (Poppins)',
    'Responsive layout for all screen sizes',
    'Smooth animations and transitions',
    'Professional color scheme',
    'Accessibility features',
    'Business mode toggle',
    'Intuitive navigation system',
  ];

  /// 🚀 Technical Capabilities
  static const List<String> technicalFeatures = [
    'Flutter 3.8+ with Material Design 3',
    'Professional camera plugin integration',
    'Advanced video player with controls',
    'Image picker for gallery integration',
    'State management with Provider',
    'Local storage and file management',
    'Error handling and validation',
    'Performance optimization',
  ];

  /// 📊 Business Use Cases
  static const List<String> businessUseCases = [
    'Content Creators: Professional video/photo creation',
    'Small Businesses: Brand content management',
    'Marketing Teams: Campaign analytics and scheduling',
    'Social Media Managers: Multi-platform content',
    'Influencers: Engagement tracking and insights',
    'Agencies: Client content management',
    'E-commerce: Product showcase and marketing',
    'Educational: Course content and tutorials',
  ];

  /// 🔧 Configuration Options
  static const Map<String, List<String>> configurationOptions = {
    'Camera Settings': [
      'Resolution: Low, Medium, High, Very High, Ultra High',
      'Flash: Off, Torch',
      'Grid Overlay: Toggle on/off',
      'Camera: Front/Back switching',
      'Audio: Enable/disable recording',
    ],
    'Business Mode': [
      'Categories: General, Business, Technology, Lifestyle, Food, Travel, Fitness, Education, Entertainment',
      'Post Scheduling: Date and time selection',
      'Analytics: Performance tracking',
      'Content Management: Drafts and calendar',
      'Privacy: Public/private posts',
    ],
    'Post Settings': [
      'Privacy: Public, Private',
      'Comments: Enable/disable',
      'Engagement: Analytics tracking',
      'Location: Tagging support',
      'Hashtags: Multiple tag support',
    ],
  };

  /// 🎯 Next Phase Features (Planned)
  static const List<String> plannedFeatures = [
    'Firebase integration for cloud storage',
    'Real-time analytics dashboard',
    'AI-powered content recommendations',
    'Multi-platform social media posting',
    'Team collaboration tools',
    'Advanced content scheduling',
    'User authentication and profiles',
    'Social networking features',
  ];

  /// 📱 How to Use Business Mode
  static const List<String> businessModeUsage = [
    '1. Toggle Business Mode in the header',
    '2. Select content category before recording',
    '3. Use advanced camera features (grid, flash, resolution)',
    '4. Create posts with business-specific options',
    '5. Schedule content for optimal engagement',
    '6. Track performance in analytics dashboard',
    '7. Manage content in dedicated sections',
    '8. Access business insights and recommendations',
  ];

  /// 🎥 Video Recording Tips
  static const List<String> videoTips = [
    'Use grid overlay for professional composition',
    'Select appropriate resolution for your content',
    'Enable flash in low-light conditions',
    'Long-press to start video recording',
    'Release to stop recording',
    'Use business mode for categorized content',
    'Add captions and hashtags for better reach',
    'Schedule posts during peak engagement hours',
  ];

  /// 🏆 Success Metrics
  static const Map<String, String> successMetrics = {
    'Engagement Rate': 'Track likes, comments, and shares',
    'View Count': 'Monitor content visibility',
    'Follower Growth': 'Measure audience expansion',
    'Content Performance': 'Analyze post success rates',
    'Scheduling Effectiveness': 'Optimize posting times',
    'Category Performance': 'Identify best content types',
    'Audience Insights': 'Understand your followers',
    'ROI Measurement': 'Track business impact',
  };
}

/// Demo widget to showcase features
class RevvFeatureShowcase extends StatelessWidget {
  const RevvFeatureShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Revv Business Features',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeatureSection('🎥 Professional Camera', RevvBusinessFeatures.cameraFeatures),
            const SizedBox(height: 30),
            _buildFeatureSection('📱 Advanced Posts', RevvBusinessFeatures.postFeatures),
            const SizedBox(height: 30),
            _buildFeatureSection('🏢 Business Dashboard', RevvBusinessFeatures.businessFeatures),
            const SizedBox(height: 30),
            _buildFeatureSection('🎨 Professional UI/UX', RevvBusinessFeatures.uiFeatures),
            const SizedBox(height: 30),
            _buildFeatureSection('🚀 Technical Capabilities', RevvBusinessFeatures.technicalFeatures),
            const SizedBox(height: 30),
            _buildFeatureSection('📊 Business Use Cases', RevvBusinessFeatures.businessUseCases),
            const SizedBox(height: 30),
            _buildConfigurationSection(),
            const SizedBox(height: 30),
            _buildFeatureSection('🎯 Planned Features', RevvBusinessFeatures.plannedFeatures),
            const SizedBox(height: 30),
            _buildFeatureSection('📱 Business Mode Usage', RevvBusinessFeatures.businessModeUsage),
            const SizedBox(height: 30),
            _buildFeatureSection('🎥 Video Recording Tips', RevvBusinessFeatures.videoTips),
            const SizedBox(height: 30),
            _buildSuccessMetricsSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureSection(String title, List<String> features) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...features.map((feature) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  feature,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildConfigurationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🔧 Configuration Options',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...RevvBusinessFeatures.configurationOptions.entries.map((entry) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...entry.value.map((option) => Padding(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Row(
                  children: [
                    Icon(Icons.arrow_right, color: Colors.blue, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        option,
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildSuccessMetricsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🏆 Success Metrics',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...RevvBusinessFeatures.successMetrics.entries.map((entry) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.trending_up, color: Colors.green, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: GoogleFonts.poppins(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      entry.value,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }
}
