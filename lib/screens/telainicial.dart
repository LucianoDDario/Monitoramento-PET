import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tela_pet.dart'; 
import 'adiciona_pet.dart';
import 'tela_configuracao.dart'; 
import 'tela_galeria.dart';      

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  static const corBrand = Color(0xFFD02670);
  static const corFundo = Color(0xFFF5F5F5); 
  static const corTexto = Colors.black;

  final List<Map<String, String>> _pets = [
    {
      'nome': 'Yuumi',
      'idade': '14 anos',
      'peso': '14 kg',
      'alarmes': '4 alarmes',
      'midias': '100 mídias',
    },
    {
      'nome': 'Billy',
      'idade': '5 anos',
      'peso': '8 kg',
      'alarmes': '2 alarmes',
      'midias': '32 mídias',
    },
    {
      'nome': 'Thor',
      'idade': '2 anos',
      'peso': '25 kg',
      'alarmes': '1 alarme',
      'midias': '12 mídias',
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // --- CABEÇALHO ---
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.black12)),
              ),
              child: Row(
                children: [
                   Image.asset(
                    'assets/images/Pets.png', 
                    width: 24,
                    height: 24,
                    errorBuilder: (c, e, s) => const Icon(Icons.pets_outlined, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Pets',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),

            // --- CORPO PRINCIPAL (ROSA) ---
            Expanded(
              child: Container(
                color: corBrand, 
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0), 
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                        child: Column(
                          children: [
                            // Título e Botão de Configuração
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Meus pets',
                                    style: TextStyle(
                                      color: corBrand,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const TelaConfiguracao(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.person_outline, color: Colors.grey, size: 24),
                                    tooltip: 'Configurações',
                                  ),
                                ],
                              ),
                            ),

                            // GRID DE PETS
                            Expanded(
                              child: GridView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.62, 
                                ),
                                itemCount: _pets.length + 1, 
                                itemBuilder: (context, index) {
                                  if (index == _pets.length) {
                                    return _buildCardAdicionar();
                                  }
                                  return _buildCardPet(_pets[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- MENU INFERIOR (Sem "Ver mais") ---
            Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.black12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribui os 2 itens igualmente
                children: [
                  _buildMenuItem(
                    icon: Icons.favorite, 
                    label: 'Meus pets', 
                    isActive: true,
                    onTap: () {}, 
                  ),
                  _buildMenuItem(
                    icon: Icons.image_outlined, 
                    label: 'Galeria', 
                    isActive: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TelaGaleria()),
                      );
                    },
                  ),
                  // Botão "Ver mais" removido conforme solicitado
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardPet(Map<String, String> pet) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TelaPet()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3E5F5).withOpacity(0.3), 
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                height: 80, 
                width: 100,
                color: Colors.grey.shade300, 
                child: Image.asset(
                  'assets/images/gato_placeholder.png', 
                  fit: BoxFit.cover,
                  errorBuilder: (c,e,s) => const Icon(Icons.photo, color: Colors.grey),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                pet['nome']!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),

            _buildInfoRow(Icons.calendar_today_outlined, pet['idade']!),
            _buildInfoRow(Icons.speed_outlined, pet['peso']!), 
            _buildInfoRow(Icons.access_alarm, pet['alarmes']!),
            _buildInfoRow(Icons.camera_alt_outlined, pet['midias']!),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            Icon(icon, size: 12, color: Colors.black54),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 11, color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardAdicionar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TelaCadastroPet(), 
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3E5F5).withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.black, size: 30),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon, 
    required String label, 
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector( 
      onTap: onTap,
      behavior: HitTestBehavior.opaque, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: isActive 
              ? BoxDecoration(
                  border: Border.all(color: corBrand),
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
            child: Icon(
              icon, 
              color: isActive ? corBrand : Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}