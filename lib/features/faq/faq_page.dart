import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final List<String> categories = ["General", "Account", "Service", "Payment"];
  String selectedCategory = "General";

  final List<Map<String, String>> faqs = [
    {
      "question": "How do I make a purchase?",
      "answer":
      "When you find a product you want to purchase, tap on it to view the product details. "
          "Check the price, description, and available options (if applicable), and then tap "
          "the 'Add to Cart' button. Follow the on-screen instructions to complete the purchase, "
          "including providing shipping details and payment information."
    },
    {
      "question": "What payment methods are accepted?",
      "answer": "We accept credit/debit cards, PayPal, and other local payment options."
    },
    {
      "question": "How do I track my orders?",
      "answer": "Go to 'My Orders' in your account section and select the order to track."
    },
    {
      "question": "Can I cancel or return an order?",
      "answer": "Yes, orders can be cancelled within 24 hours or returned within 14 days."
    },
    {
      "question": "How can I contact customer support for assistance?",
      "answer": "You can contact our support team via email or the in-app chat feature."
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredFaqs = faqs.where((faq) {
      return faq["question"]!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.go('/myAccount'),
        ),
        title: const Text(
          "FAQs",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Category Tabs
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = cat),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: categories.length,
              ),
            ),
            const SizedBox(height: 16),

            /// Search Bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.mic_none),
                hintText: "Search for questions...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              onChanged: (val) => setState(() => searchQuery = val),
            ),
            const SizedBox(height: 16),

            /// FAQ List
            Expanded(
              child: ListView.builder(
                itemCount: filteredFaqs.length,
                itemBuilder: (context, index) {
                  final faq = filteredFaqs[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ExpansionTile(
                      title: Text(
                        faq["question"]!,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            faq["answer"]!,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
