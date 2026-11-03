
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme/nova_colors.dart';
import '../../../core/widgets/glass_container.dart';

class CardsManagementScreen extends StatefulWidget {
  const CardsManagementScreen({super.key});

  @override
  State<CardsManagementScreen> createState() =>
      _CardsManagementScreenState();
}

class _CardsManagementScreenState
    extends State<CardsManagementScreen> {
  final PageController _controller = PageController(
    viewportFraction: 0.91,
  );

  final List<_ManagedCard> _cards = [
    _ManagedCard(
      name: 'NOVA DEBIT',
      number: '7714',
      holder: 'DANIEL LAUREN',
      gradient: const [
        Color(0xFFE94B63),
        Color(0xFFB71935),
        Color(0xFF570D22),
      ],
    ),
    _ManagedCard(
      name: 'NOVA PREMIUM',
      number: '2293',
      holder: 'DANIEL LAUREN',
      gradient: const [
        Color(0xFF8B647D),
        Color(0xFF4B2847),
        Color(0xFF211323),
      ],
    ),
  ];

  int _selectedCard = 0;
  bool _showDetails = false;
  bool _isFrozen = false;
  bool _onlinePayments = true;
  bool _contactlessPayments = true;
  bool _atmWithdrawals = true;
  double _spendingLimit = 2500;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _message(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: NovaColors.darkMaroon,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _addVirtualCard() {
    setState(() {
      _cards.add(
        _ManagedCard(
          name: 'NOVA VIRTUAL',
          number: '8842',
          holder: 'DANIEL LAUREN',
          gradient: const [
            Color(0xFF477B91),
            Color(0xFF244D68),
            Color(0xFF142A40),
          ],
        ),
      );

      _selectedCard = _cards.length - 1;
      _showDetails = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateToPage(
          _selectedCard,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
        );
      }
    });

    _message('Your virtual card has been created.');
  }

  @override
  Widget build(BuildContext context) {
    final selected = _cards[_selectedCard];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCardHeading(),

        const SizedBox(height: 22),

        _buildCardCarousel(),

        const SizedBox(height: 16),

        _buildCardPosition(),

        const SizedBox(height: 22),

        _buildCardDetails(selected),

        const SizedBox(height: 24),

        _buildSecurityStatus(),

        const SizedBox(height: 24),

        _buildSectionTitle('Card controls'),

        const SizedBox(height: 12),

        _buildCardControls(),

        const SizedBox(height: 24),

        _buildSectionTitle('Monthly spending limit'),

        const SizedBox(height: 12),

        _buildSpendingLimit(),

        const SizedBox(height: 24),

        _buildSectionTitle('Recent card transactions'),

        const SizedBox(height: 12),

        _buildTransactions(),

        const SizedBox(height: 24),

        _buildAddCardButton(),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCardHeading() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'My Cards',
            style: GoogleFonts.manrope(
              color: NovaColors.white,
              fontSize: 29,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: NovaColors.success.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${_cards.length} cards',
            style: GoogleFonts.manrope(
              color: NovaColors.success,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardCarousel() {
    return SizedBox(
      height: 205,
      child: PageView.builder(
        controller: _controller,
        itemCount: _cards.length,
        onPageChanged: (index) {
          setState(() {
            _selectedCard = index;
            _showDetails = false;
          });
        },
        itemBuilder: (context, index) {
          final card = _cards[index];

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: AnimatedScale(
              scale: index == _selectedCard ? 1 : 0.94,
              duration: const Duration(milliseconds: 300),
              child: _buildBankCard(card),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBankCard(_ManagedCard card) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: card.gradient,
        ),
        borderRadius: BorderRadius.circular(27),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: card.gradient.first.withValues(alpha: 0.24),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.07),
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
                      fontSize: 13,
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
                    width: 40,
                    height: 29,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9C18B),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.memory_rounded,
                      color: Color(0xFF6C5734),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _showDetails
                        ? '4582  9012  3456  ${card.number}'
                        : '••••  ••••  ••••  ${card.number}',
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
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
                          color: Colors.white70,
                          fontSize: 8,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        card.holder,
                        style: GoogleFonts.manrope(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'VISA',
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 23,
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

  Widget _buildCardPosition() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _cards.length,
            (index) {
          final active = index == _selectedCard;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: active ? 24 : 7,
            height: 7,
            decoration: BoxDecoration(
              color: active
                  ? NovaColors.coral
                  : NovaColors.glassBorder,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardDetails(_ManagedCard card) {
    return GlassContainer(
      radius: 22,
      opacity: 0.13,
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.credit_card_rounded,
                color: NovaColors.coral,
              ),
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
                onPressed: () {
                  setState(() {
                    _showDetails = !_showDetails;
                  });
                },
                icon: Icon(
                  _showDetails
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: NovaColors.coral,
                ),
              ),
            ],
          ),

          const Divider(color: NovaColors.glassBorder),

          _detailRow(
            'Card number',
            _showDetails
                ? '4582 9012 3456 ${card.number}'
                : '•••• •••• •••• ${card.number}',
          ),

          _detailRow(
            'Expiry date',
            _showDetails ? '12/29' : '••/••',
          ),

          _detailRow(
            'CVV',
            _showDetails ? '***' : '•••',
          ),

          const SizedBox(height: 8),

          Text(
            'Demo card information only. No real payment credentials.',
            style: GoogleFonts.manrope(
              color: NovaColors.mutedWhite,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.manrope(
                color: NovaColors.mutedWhite,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.manrope(
              color: NovaColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityStatus() {
    return GlassContainer(
      radius: 20,
      opacity: 0.12,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: (_isFrozen
                  ? NovaColors.negative
                  : NovaColors.success)
                  .withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              _isFrozen
                  ? Icons.lock_rounded
                  : Icons.shield_rounded,
              color: _isFrozen
                  ? NovaColors.negative
                  : NovaColors.success,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isFrozen ? 'Card frozen' : 'Card protected',
                  style: GoogleFonts.manrope(
                    color: NovaColors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isFrozen
                      ? 'Payments are disabled in this demo.'
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
            value: _isFrozen,
            activeThumbColor: NovaColors.negative,
            onChanged: (value) {
              setState(() {
                _isFrozen = value;
              });

              _message(
                value
                    ? 'Your demo card is frozen.'
                    : 'Your demo card is active again.',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.manrope(
        color: NovaColors.white,
        fontSize: 17,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildCardControls() {
    return GlassContainer(
      radius: 22,
      opacity: 0.12,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          _controlRow(
            icon: Icons.language_rounded,
            title: 'Online payments',
            subtitle: 'Use your card for online purchases',
            value: _onlinePayments,
            onChanged: (value) {
              setState(() => _onlinePayments = value);
            },
          ),
          const Divider(color: NovaColors.glassBorder),
          _controlRow(
            icon: Icons.contactless_rounded,
            title: 'Contactless payments',
            subtitle: 'Tap to pay in stores',
            value: _contactlessPayments,
            onChanged: (value) {
              setState(() => _contactlessPayments = value);
            },
          ),
          const Divider(color: NovaColors.glassBorder),
          _controlRow(
            icon: Icons.atm_rounded,
            title: 'ATM withdrawals',
            subtitle: 'Allow cash withdrawals',
            value: _atmWithdrawals,
            onChanged: (value) {
              setState(() => _atmWithdrawals = value);
            },
          ),
        ],
      ),
    );
  }

  Widget _controlRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: NovaColors.coral, size: 21),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    color: NovaColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.manrope(
                    color: NovaColors.mutedWhite,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeThumbColor: NovaColors.coral,
            onChanged: _isFrozen ? null : onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingLimit() {
    return GlassContainer(
      radius: 22,
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
          const SizedBox(height: 12),
          Slider(
            value: _spendingLimit,
            min: 500,
            max: 10000,
            divisions: 19,
            activeColor: NovaColors.coral,
            inactiveColor: NovaColors.glassBorder,
            onChanged: (value) {
              setState(() {
                _spendingLimit = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '€500',
                style: GoogleFonts.manrope(
                  color: NovaColors.mutedWhite,
                  fontSize: 10,
                ),
              ),
              Text(
                '€10,000',
                style: GoogleFonts.manrope(
                  color: NovaColors.mutedWhite,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'This setting is stored locally for demonstration.',
            style: GoogleFonts.manrope(
              color: NovaColors.mutedWhite,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactions() {
    final transactions = [
      (
      'Spotify Premium',
      'Entertainment · Today',
      '-€9.99',
      Icons.music_note_rounded,
      ),
      (
      'Netflix',
      'Entertainment · Yesterday',
      '-€15.49',
      Icons.movie_rounded,
      ),
      (
      'Grocery Store',
      'Shopping · Yesterday',
      '-€64.20',
      Icons.shopping_bag_rounded,
      ),
    ];

    return GlassContainer(
      radius: 22,
      opacity: 0.12,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: transactions.map((transaction) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 41,
                  height: 41,
                  decoration: BoxDecoration(
                    color: NovaColors.coral.withValues(alpha: 0.13),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    transaction.$4,
                    color: NovaColors.coral,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.$1,
                        style: GoogleFonts.manrope(
                          color: NovaColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        transaction.$2,
                        style: GoogleFonts.manrope(
                          color: NovaColors.mutedWhite,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  transaction.$3,
                  style: GoogleFonts.manrope(
                    color: NovaColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAddCardButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _addVirtualCard,
        icon: const Icon(Icons.add_card_rounded),
        label: const Text('Add virtual card'),
        style: OutlinedButton.styleFrom(
          foregroundColor: NovaColors.white,
          side: const BorderSide(
            color: NovaColors.glassBorder,
          ),
          padding: const EdgeInsets.symmetric(vertical: 17),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

class _ManagedCard {
  const _ManagedCard({
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
