import 'package:flutter/material.dart';

class PricingPolicyPage extends StatefulWidget {
  const PricingPolicyPage({super.key});

  @override
  State<PricingPolicyPage> createState() => _PricingPolicyPageState();
}

class _PricingPolicyPageState extends State<PricingPolicyPage> {
  int? _selectedPlan;

  final plans = [
    {
      'title': 'Basic Plan',
      'price': '₹499/month',
      'features': ['Up to 10 hours care', 'Basic support', '1 caregiver'],
    },
    {
      'title': 'Standard Plan',
      'price': '₹999/month',
      'features': ['Up to 30 hours care', 'Priority support', '2 caregivers'],
    },
    {
      'title': 'Premium Plan',
      'price': '₹1499/month',
      'features': ['Unlimited care', '24/7 support', 'Multiple caregivers'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pricing Policy')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: plans.length,
                itemBuilder: (context, i) {
                  final plan = plans[i];
                  final isSelected = _selectedPlan == i;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPlan = i;
                      });
                    },
                    child: Card(
                      color: isSelected ? Colors.teal[100] : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isSelected
                              ? Colors.teal
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan['title'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              plan['price'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...List.generate(
                              (plan['features'] as List).length,
                              (j) => Row(
                                children: [
                                  const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 6),
                                  Text((plan['features'] as List<String>)[j]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: _selectedPlan != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to payment or next step
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Continue to Payment',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
