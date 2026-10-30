
import 'package:flutter/material.dart';

void main() {
  runApp(const LoyaltyApp());
}

const preto = Color(0xFF101010);
const verde = Color(0xFF536343);

class Produto {
  final String nome;
  final String categoria;
  final String imagem;
  final String descricao;
  final double preco;

  const Produto({
    required this.nome,
    required this.categoria,
    required this.imagem,
    required this.descricao,
    required this.preco,
  });
}

const produtos = [
  Produto(
    nome: 'LOYALTY Oversized Black',
    categoria: 'Camisetas',
    imagem: 'assets/images/camisa_preta.png',
    descricao: 'Camiseta oversized preta, estilo urbano.',
    preco: 89.90,
  ),
  Produto(
    nome: 'LOYALTY Oversized White',
    categoria: 'Camisetas',
    imagem: 'assets/images/camisa_branca.png',
    descricao: 'Camiseta oversized branca, modelagem larga.',
    preco: 89.90,
  ),
  Produto(
    nome: 'LOYALTY Hoodie',
    categoria: 'Moletons',
    imagem: 'assets/images/moletom.png',
    descricao: 'Moletom verde militar com estilo streetwear.',
    preco: 189.90,
  ),
  Produto(
    nome: 'LOYALTY Street Cap',
    categoria: 'Street Essentials',
    imagem: 'assets/images/bone.png',
    descricao: 'Boné preto para completar o visual.',
    preco: 69.90,
  ),
];

String formatarPreco(double preco) {
  return 'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}';
}

class LoyaltyApp extends StatelessWidget {
  const LoyaltyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOYALTY',
      theme: ThemeData(
        scaffoldBackgroundColor: preto,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: verde,
          brightness: Brightness.dark,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class LogoLoyalty extends StatelessWidget {
  const LogoLoyalty({super.key, this.tamanho = 100});

  final double tamanho;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: tamanho,
      height: tamanho,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.local_fire_department,
          size: tamanho * 0.7,
          color: Colors.white,
        );
      },
    );
  }
}

class ImagemProduto extends StatelessWidget {
  const ImagemProduto({
    super.key,
    required this.imagem,
  });

  final String imagem;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagem,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(
            Icons.checkroom,
            size: 65,
            color: Colors.white54,
          ),
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoLoyalty(tamanho: 160),
            SizedBox(height: 20),
            Text(
              'LOYALTY',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w900,
                letterSpacing: 5,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'LOYALTY ABOVE EVERYTHING',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 35),
            CircularProgressIndicator(color: verde),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: preto,
        centerTitle: true,
        title: const Text(
          'LOYALTY',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: LogoLoyalty(tamanho: 110),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: verde,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Text(
                    'DROP 001',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'BORN IN THE STREETS',
                    style: TextStyle(letterSpacing: 2),
                  ),
                  SizedBox(height: 12),
                  Text('Conheça nossa primeira coleção.'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'NOSSA COLEÇÃO',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 15),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: produtos.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 265,
              ),
              itemBuilder: (context, index) {
                final produto = produtos[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalheProduto(
                          produto: produto,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF202020),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: ImagemProduto(
                                imagem: produto.imagem,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                produto.nome,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                produto.categoria,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                formatarPreco(produto.preco),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'SOBRE A LOYALTY',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'A LOYALTY é uma marca de streetwear '
              'inspirada na cultura das ruas. '
              'Representamos lealdade, atitude e autenticidade.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 25),
            const Center(
              child: Text(
                'LOYALTY ABOVE EVERYTHING.',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetalheProduto extends StatelessWidget {
  const DetalheProduto({
    super.key,
    required this.produto,
  });

  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: preto,
        title: const Text('LOYALTY'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF202020),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ImagemProduto(
                  imagem: produto.imagem,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              produto.categoria.toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              produto.nome,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              formatarPreco(produto.preco),
              style: const TextStyle(
                fontSize: 23,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              produto.descricao,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: verde,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(18),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Produto demonstrativo - DROP 001',
                      ),
                    ),
                  );
                },
                child: const Text('TENHO INTERESSE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
