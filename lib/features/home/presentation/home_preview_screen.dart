import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme/nova_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/gradient_background.dart';

class HomePreviewScreen extends StatefulWidget {
  const HomePreviewScreen({super.key});

  @override
  State<HomePreviewScreen> createState() => _HomePreviewScreenState();
}

class _HomePreviewScreenState extends State<HomePreviewScreen> {
  int _selectedTab = 0;
  int _selectedCard = 0;
  bool _showCardDetails = false;
  bool _isCardFrozen = false;
  bool _onlinePayments = true;
  bool _contactlessPayments = true;
  bool _atmWithdrawals = true;
  double _spendingLimit = 2500;

  final PageController _cardController = PageController(
    viewportFraction: 0.88,
  );

  final List<_NovaTransaction> _transactions = const [
    _NovaTransaction(
      name: 'Spotify Premium',
      category: 'Entertainment',
      date: 'Today, 10:42 AM',
      amount: '-€9.99',
      icon: Icons.music_note_rounded,
      color: Color(0xFF25C875),
      isIncome: false,
    ),
    _NovaTransaction(
      name: 'Elizabeth Z.',
      category: 'Money received',
      date: 'Today, 09:15 AM',
      amount: '+€20.99',
      icon: Icons.person_rounded,
      color: Color(0xFF9C7BFF),
      isIncome: true,
    ),
    _NovaTransaction(
      name: 'Netflix',
      category: 'Entertainment',
      date: 'Yesterday',
      amount: '-€15.49',
      icon: Icons.movie_rounded,
      color: Color(0xFFE34B5C),
      isIncome: false,
    ),
    _NovaTransaction(
      name: 'Grocery Store',
      category: 'Shopping',
      date: 'Yesterday',
      amount: '-€64.20',
      icon: Icons.shopping_bag_rounded,
      color: Color(0xFFFFA45B),
      isIncome: false,
    ),
    _NovaTransaction(
      name: 'Monthly Salary',
      category: 'Income',
      date: 'Oct 30, 2026',
      amount: '+€2,850.00',
      icon: Icons.account_balance_wallet_rounded,
      color: Color(0xFF52C7D9),
      isIncome: true,
    ),
  ];

  final List<_NovaCardData> _cards = [
    _NovaCardData(
      name: 'NOVA DEBIT',
      number: '••  ••  ••  7714',
      holder: 'DANIEL LAUREN',
      gradient: [
        Color(0xFFE94B63),
        Color(0xFFB71935),
        Color(0xFF570D22),
      ],
    ),
    _NovaCardData(
      name: 'NOVA PREMIUM',
      number: '••  ••  ••  2293',
      holder: 'DANIEL LAUREN',
      gradient: [
        Color(0xFF8B647D),
        Color(0xFF4B2847),
        Color(0xFF211323),
      ],
    ),
  ];

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: NovaColors.darkMaroon,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NovaColors.background,
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: _selectedTab == 0
                    ? _buildHomeContent()
                    : _buildOtherTab(),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 10,
                child: _buildBottomNavigation(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 115),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 30),
          _buildBalance(),
          const SizedBox(height: 28),
          _buildSectionHeading(
            title: 'Your cards',
            action: 'Manage',
            onTap: () {
              setState(() => _selectedTab = 1);
            },
          ),
          const SizedBox(height: 14),
          _buildCardCarousel(),
          const SizedBox(height: 28),
          _buildQuickActions(),
          const SizedBox(height: 30),
          _buildSectionHeading(
            title: 'Recent transactions',
            action: 'See all',
            onTap: () {
              setState(() => _selectedTab = 2);
            },
          ),
          const SizedBox(height: 12),
          _buildTransactionList(limit: 4),
          const SizedBox(height: 24),
          _buildMonthlyInsight(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: NovaColors.buttonGradient,
            border: Border.all(
              color: NovaColors.glassBorder,
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.person_rounded,
            color: NovaColors.white,
            size: 25,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning,',
                style: GoogleFonts.manrope(
                  color: NovaColors.mutedWhite,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Daniel Lauren',
                style: GoogleFonts.manrope(
                  color: NovaColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        _roundIconButton(
          icon: Icons.search_rounded,
          onTap: () => _showMessage('Search will be added soon.'),
        ),
        const SizedBox(width: 10),
        Stack(
          clipBehavior: Clip.none,
          children: [
            _roundIconButton(
              icon: Icons.notifications_none_rounded,
              onTap: () => _showMessage('You are all caught up!'),
            ),
            Positioned(
              top: 9,
              right: 10,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: NovaColors.coral,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _roundIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: GlassContainer(
          radius: 17,
          blur: 12,
          opacity: 0.12,
          padding: const EdgeInsets.all(11),
          child: Icon(
            icon,
            color: NovaColors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildBalance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'TOTAL BALANCE',
              style: GoogleFonts.manrope(
                color: NovaColors.mutedWhite,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.visibility_outlined,
              color: NovaColors.mutedWhite,
              size: 15,
            ),
          ],
        ),
        const SizedBox(height: 9),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '€33,350',
              style: GoogleFonts.manrope(
                color: NovaColors.white,
                fontSize: 38,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.8,
                height: 1.1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                '.00',
                style: GoogleFonts.manrope(
                  color: NovaColors.softWhite.withValues(alpha: 0.65),
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 11),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: NovaColors.success.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: NovaColors.success.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.trending_up_rounded,
                color: NovaColors.success,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                '+24.6%',
                style: GoogleFonts.manrope(
                  color: NovaColors.success,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                'vs last month',
                style: GoogleFonts.manrope(
                  color: NovaColors.softWhite,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeading({
    required String title,
    required String action,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.manrope(
              color: NovaColors.white,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: NovaColors.coral,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            minimumSize: const Size(0, 35),
          ),
          child: Text(
            action,
            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 190,
          child: PageView.builder(
            controller: _cardController,
            itemCount: _cards.length,
            onPageChanged: (index) {
              setState(() => _selectedCard = index);
            },
            itemBuilder: (context, index) {
              final card = _cards[index];

              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _buildBankCard(card),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _cards.length,
                (index) {
              final active = index == _selectedCard;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 22 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: active
                      ? NovaColors.coral
                      : Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBankCard(_NovaCardData card) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: card.gradient,
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.24),
        ),
        boxShadow: [
          BoxShadow(
            color: card.gradient.first.withValues(alpha: 0.25),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -35,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            right: 25,
            bottom: -65,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 25,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    card.name,
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.wifi_rounded,
                    color: Colors.white,
                    size: 23,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    width: 39,
                    height: 29,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9C18B),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.memory_rounded,
                      color: Color(0xFF6C5734),
                      size: 23,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    card.number,
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CARD HOLDER',
                        style: GoogleFonts.manrope(
                          color: Colors.white.withValues(alpha: 0.65),
                          fontSize: 8,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        card.holder,
                        style: GoogleFonts.manrope(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'VISA',
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      _QuickActionData(
        label: 'Send',
        icon: Icons.arrow_upward_rounded,
        color: const Color(0xFFFF7181),
      ),
      _QuickActionData(
        label: 'Request',
        icon: Icons.arrow_downward_rounded,
        color: const Color(0xFFB99AFF),
      ),
      _QuickActionData(
        label: 'Top up',
        icon: Icons.add_rounded,
        color: const Color(0xFF69D5B1),
      ),
      _QuickActionData(
        label: 'Pay in',
        icon: Icons.qr_code_scanner_rounded,
        color: const Color(0xFFFFB36D),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((action) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              _showMessage('${action.label} will be available soon.');
            },
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.09),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: NovaColors.glassBorder,
                    ),
                  ),
                  child: Icon(
                    action.icon,
                    color: action.color,
                    size: 23,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  action.label,
                  style: GoogleFonts.manrope(
                    color: NovaColors.softWhite,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTransactionList({int? limit}) {
    final items = limit == null
        ? _transactions
        : _transactions.take(limit).toList();

    return Column(
      children: items.map(_buildTransactionTile).toList(),
    );
  }

  Widget _buildTransactionTile(_NovaTransaction transaction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: transaction.color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              transaction.icon,
              color: transaction.color,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.name,
                  style: GoogleFonts.manrope(
                    color: NovaColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.date,
                  style: GoogleFonts.manrope(
                    color: NovaColors.mutedWhite,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Text(
            transaction.amount,
            style: GoogleFonts.manrope(
              color: transaction.isIncome
                  ? NovaColors.success
                  : NovaColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyInsight() {
    return GlassContainer(
      radius: 22,
      blur: 18,
      opacity: 0.12,
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: NovaColors.coral.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.auto_graph_rounded,
              color: NovaColors.coral,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your money is growing',
                  style: GoogleFonts.manrope(
                    color: NovaColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your balance increased by 24.6% this month.',
                  style: GoogleFonts.manrope(
                    color: NovaColors.mutedWhite,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: NovaColors.mutedWhite,
            size: 14,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    const items = [
      _NavigationItem(
        label: 'Home',
        icon: Icons.home_rounded,
      ),
      _NavigationItem(
        label: 'Cards',
        icon: Icons.credit_card_rounded,
      ),
      _NavigationItem(
        label: 'Activity',
        icon: Icons.swap_horiz_rounded,
      ),
      _NavigationItem(
        label: 'Insights',
        icon: Icons.bar_chart_rounded,
      ),
      _NavigationItem(
        label: 'Profile',
        icon: Icons.person_outline_rounded,
      ),
    ];

    return GlassContainer(
      radius: 30,
      blur: 25,
      opacity: 0.22,
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 9,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final active = _selectedTab == index;

          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  _selectedTab = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: active
                      ? NovaColors.red.withValues(alpha: 0.20)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: active ? 35 : 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: active
                            ? NovaColors.red
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item.icon,
                        color: active
                            ? NovaColors.white
                            : NovaColors.mutedWhite,
                        size: 19,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        color: active
                            ? NovaColors.white
                            : NovaColors.mutedWhite,
                        fontSize: 9,
                        fontWeight: active
                            ? FontWeight.w800
                            : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildOtherTab() {
    final titles = [
      'Home',
      'My Cards',
      'Activity',
      'Insights',
      'Profile',
    ];

    final descriptions = [
      '',
      'Manage your Nova debit and premium cards.',
      'Review your income and spending transactions.',
      'Understand your spending and financial habits.',
      'Manage your personal information and preferences.',
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titles[_selectedTab],
            style: GoogleFonts.manrope(
              color: NovaColors.white,
              fontSize: 29,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            descriptions[_selectedTab],
            style: GoogleFonts.manrope(
              color: NovaColors.mutedWhite,
              fontSize: 13,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 28),
          if (_selectedTab == 2) ...[
            _buildSectionHeading(
              title: 'All transactions',
              action: '${_transactions.length} items',
              onTap: () {},
            ),
            const SizedBox(height: 15),
            _buildTransactionList(),
          ] else if (_selectedTab == 1) ...[
            _buildCardCarousel(),
            const SizedBox(height: 14),
            _buildCardManagementDetails(),
            const SizedBox(height: 22),
            _buildCardSecurityControl(),
            const SizedBox(height: 22),
            _buildCardControls(),
            const SizedBox(height: 22),
            _buildSpendingLimitControl(),
            const SizedBox(height: 22),
            _buildSectionHeading(
              title: 'Recent card transactions',
              action: 'View all',
              onTap: () => setState(() => _selectedTab = 2),
            ),
            const SizedBox(height: 12),
            _buildTransactionList(limit: 3),
            const SizedBox(height: 10),
            _buildAddVirtualCardButton(),
          ] else if (_selectedTab == 3) ...[
            _buildPlaceholderFeature(
              icon: Icons.pie_chart_outline_rounded,
              title: 'Spending insights',
              description: 'Your monthly spending breakdown and charts will appear here.',
            ),
            const SizedBox(height: 15),
            _buildPlaceholderFeature(
              icon: Icons.savings_outlined,
              title: 'Savings progress',
              description: 'Track your savings goals and monthly progress here.',
            ),
          ] else if (_selectedTab == 4) ...[
            _buildPlaceholderFeature(
              icon: Icons.person_outline_rounded,
              title: 'Daniel Lauren',
              description: 'Personal profile and account preferences.',
            ),
            const SizedBox(height: 15),
            _buildPlaceholderFeature(
              icon: Icons.security_rounded,
              title: 'Security',
              description: 'Security and privacy settings will be added here.',
            ),
            const SizedBox(height: 15),
            _buildPlaceholderFeature(
              icon: Icons.help_outline_rounded,
              title: 'Help and support',
              description: 'Support options will be added here.',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCardManagementDetails() {
    final card = _cards[_selectedCard];

    return GlassContainer(
      radius: 22,
      blur: 16,
      opacity: 0.13,
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.credit_card_rounded, color: NovaColors.coral),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Card information',
                  style: GoogleFonts.manrope(
                    color: NovaColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                tooltip: _showCardDetails ? 'Hide details' : 'Show details',
                onPressed: () => setState(() => _showCardDetails = !_showCardDetails),
                icon: Icon(
                  _showCardDetails
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: NovaColors.coral,
                ),
              ),
            ],
          ),
          const Divider(color: NovaColors.glassBorder),
          _cardDetailRow(
            'Card number',
            _showCardDetails
                ? '4582 9012 3456 ${card.number.replaceAll(RegExp(r'[^0-9]'), '')}'
                : '•••• •••• •••• ${card.number.replaceAll(RegExp(r'[^0-9]'), '')}',
          ),
          _cardDetailRow('Card holder', card.holder),
          _cardDetailRow('Expiry date', _showCardDetails ? '12/29' : '••/••'),
          _cardDetailRow('CVV', _showCardDetails ? '***' : '•••'),
          const SizedBox(height: 6),
          Text(
            'Demo card information only. No real payment credentials are stored.',
            style: GoogleFonts.manrope(
              color: NovaColors.mutedWhite,
              fontSize: 10,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.manrope(
                color: NovaColors.mutedWhite,
                fontSize: 11,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.manrope(
              color: NovaColors.white,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSecurityControl() {
    return GlassContainer(
      radius: 21,
      blur: 16,
      opacity: 0.13,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: (_isCardFrozen ? NovaColors.negative : NovaColors.success)
                  .withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              _isCardFrozen ? Icons.lock_rounded : Icons.shield_rounded,
              color: _isCardFrozen ? NovaColors.negative : NovaColors.success,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isCardFrozen ? 'Card frozen' : 'Card protected',
                  style: GoogleFonts.manrope(
                    color: NovaColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isCardFrozen
                      ? 'Card payments are disabled in this demo.'
                      : 'Your card is active and protected.',
                  style: GoogleFonts.manrope(
                    color: NovaColors.mutedWhite,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: _isCardFrozen,
            activeThumbColor: NovaColors.negative,
            onChanged: (value) {
              setState(() => _isCardFrozen = value);
              _showMessage(value ? 'Your demo card is frozen.' : 'Your demo card is active again.');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCardControls() {
    return GlassContainer(
      radius: 22,
      blur: 16,
      opacity: 0.12,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Column(
        children: [
          _cardSwitchRow(
            icon: Icons.language_rounded,
            title: 'Online payments',
            subtitle: 'Use your card for online purchases',
            value: _onlinePayments,
            onChanged: (value) => setState(() => _onlinePayments = value),
          ),
          const Divider(color: NovaColors.glassBorder),
          _cardSwitchRow(
            icon: Icons.contactless_rounded,
            title: 'Contactless payments',
            subtitle: 'Tap to pay in stores',
            value: _contactlessPayments,
            onChanged: (value) => setState(() => _contactlessPayments = value),
          ),
          const Divider(color: NovaColors.glassBorder),
          _cardSwitchRow(
            icon: Icons.atm_rounded,
            title: 'ATM withdrawals',
            subtitle: 'Allow cash withdrawals',
            value: _atmWithdrawals,
            onChanged: (value) => setState(() => _atmWithdrawals = value),
          ),
        ],
      ),
    );
  }

  Widget _cardSwitchRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Icon(icon, color: NovaColors.coral, size: 20),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    color: NovaColors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: GoogleFonts.manrope(
                    color: NovaColors.mutedWhite,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeThumbColor: NovaColors.coral,
            onChanged: _isCardFrozen ? null : onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingLimitControl() {
    return GlassContainer(
      radius: 22,
      blur: 16,
      opacity: 0.13,
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Monthly card limit',
            style: GoogleFonts.manrope(
              color: NovaColors.mutedWhite,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            '€${_spendingLimit.toStringAsFixed(0)}',
            style: GoogleFonts.manrope(
              color: NovaColors.white,
              fontSize: 27,
              fontWeight: FontWeight.w800,
            ),
          ),
          Slider(
            value: _spendingLimit,
            min: 500,
            max: 10000,
            divisions: 19,
            activeColor: NovaColors.coral,
            inactiveColor: NovaColors.glassBorder,
            onChanged: (value) => setState(() => _spendingLimit = value),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('€500', style: GoogleFonts.manrope(color: NovaColors.mutedWhite, fontSize: 10)),
              Text('€10,000', style: GoogleFonts.manrope(color: NovaColors.mutedWhite, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            'This setting is stored locally for demonstration.',
            style: GoogleFonts.manrope(color: NovaColors.mutedWhite, fontSize: 9),
          ),
        ],
      ),
    );
  }

  Widget _buildAddVirtualCardButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          if (_cards.any((card) => card.name == 'NOVA VIRTUAL')) {
            _showMessage('Your virtual demo card already exists.');
            return;
          }
          setState(() {
            _cards.add(
              _NovaCardData(
                name: 'NOVA VIRTUAL',
                number: '••  ••  ••  8842',
                holder: 'DANIEL LAUREN',
                gradient: const [
                  Color(0xFF477B91),
                  Color(0xFF244D68),
                  Color(0xFF142A40),
                ],
              ),
            );
            _selectedCard = _cards.length - 1;
            _showCardDetails = false;
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_cardController.hasClients) {
              _cardController.animateToPage(
                _selectedCard,
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeOutCubic,
              );
            }
          });
          _showMessage('Your virtual demo card has been created.');
        },
        icon: const Icon(Icons.add_card_rounded),
        label: const Text('Add virtual card'),
        style: OutlinedButton.styleFrom(
          foregroundColor: NovaColors.white,
          side: const BorderSide(color: NovaColors.glassBorder),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }

  Widget _buildPlaceholderFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return GlassContainer(
      radius: 22,
      blur: 16,
      opacity: 0.13,
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: NovaColors.coral.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: NovaColors.coral,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    color: NovaColors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: GoogleFonts.manrope(
                    color: NovaColors.mutedWhite,
                    fontSize: 10,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NovaTransaction {
  const _NovaTransaction({
    required this.name,
    required this.category,
    required this.date,
    required this.amount,
    required this.icon,
    required this.color,
    required this.isIncome,
  });

  final String name;
  final String category;
  final String date;
  final String amount;
  final IconData icon;
  final Color color;
  final bool isIncome;
}

class _NovaCardData {
  const _NovaCardData({
    required this.name,
    required this.number,
    required this.holder,
    required this.gradient,
  });

  final String name;
  final String number;
  final String holder;
  final List<Color> gradient;
}

class _QuickActionData {
  const _QuickActionData({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;
}

class _NavigationItem {
  const _NavigationItem({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}
