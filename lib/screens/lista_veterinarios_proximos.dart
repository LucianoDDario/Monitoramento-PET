import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math'; 

class ListaVeterinariosProximos extends StatefulWidget {
  const ListaVeterinariosProximos({super.key});

  @override
  State<ListaVeterinariosProximos> createState() => _ListaVeterinariosProximosState();
}

class _ListaVeterinariosProximosState extends State<ListaVeterinariosProximos> {
  static const corBrand = Color(0xFFD02670);
  static const corFundoCard = Color(0xFFF5F5F5); // Cinza claro igual do Figma
  static const corTextoCinza = Color(0xFF666666);

  bool _isLoading = true;
  String? _erro;
  List<Map<String, dynamic>> _veterinarios = [];

  @override
  void initState() {
    super.initState();
    _buscarVeterinariosProximos();
  }

  Future<void> _buscarVeterinariosProximos() async {
    try {
      Position posicaoUsuario = await _determinarPosicao();
      var listaGerada = _gerarVetsFicticios(posicaoUsuario);
      listaGerada.sort((a, b) => (a['distanciaMetros'] as double).compareTo(b['distanciaMetros'] as double));

      setState(() {
        _veterinarios = listaGerada;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _erro = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<Position> _determinarPosicao() async {
    bool servicoHabilitado;
    LocationPermission permissao;

    servicoHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicoHabilitado) {
      return Future.error('O GPS está desligado. Ligue o GPS e tente novamente.');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Permissão de localização negada.');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Permissão negada permanentemente. Habilite nas configurações.');
    }

    return await Geolocator.getCurrentPosition();
  }

  List<Map<String, dynamic>> _gerarVetsFicticios(Position usuario) {
    final random = Random();
    List<Map<String, dynamic>> lista = [];
    final nomes = [
      'Clínica Vet Vida', 'Dr. Ricardo Silva', 'Hospital Animal 24h', 
      'Dra. Fernanda Pet', 'Centro Veterinário Amigo', 'Pet Shop & Vet'
    ];

    for (var nome in nomes) {
      double latVet = usuario.latitude + (random.nextDouble() * 0.04 - 0.02);
      double longVet = usuario.longitude + (random.nextDouble() * 0.04 - 0.02);
      double distanciaMetros = Geolocator.distanceBetween(
        usuario.latitude, usuario.longitude, 
        latVet, longVet
      );

      lista.add({
        'nome': nome,
        'endereco': 'Rua Exemplo, ${random.nextInt(1000)} - Centro',
        'distanciaMetros': distanciaMetros,
      });
    }
    return lista;
  }

  String _formatarDistancia(double metros) {
    if (metros < 1000) {
      return '${metros.toStringAsFixed(0)} m';
    } else {
      return '${(metros / 1000).toStringAsFixed(1)} km';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Veterinários Próximos', 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18)
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0, // Remove a sombra para ficar clean (Flat)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: corBrand),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade200,
            height: 1.0,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: corBrand))
          : _erro != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_off_outlined, size: 60, color: Colors.grey.shade400),
                        const SizedBox(height: 20),
                        Text(
                          _erro!, 
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: corTextoCinza),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _buscarVeterinariosProximos,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: corBrand,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Tentar Novamente'),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: _veterinarios.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14), // Espaço entre cards
                  itemBuilder: (context, index) {
                    final vet = _veterinarios[index];
                    return _buildCardVeterinario(vet);
                  },
                ),
    );
  }

  // Widget Customizado para o Card do Veterinário
  Widget _buildCardVeterinario(Map<String, dynamic> vet) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: corFundoCard, // Fundo cinza claro
        borderRadius: BorderRadius.circular(12), // Bordas arredondadas
        // Se quiser sombra sutil, descomente abaixo:
        // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ícone Quadrado com Fundo Branco
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.local_hospital_rounded, color: corBrand, size: 28),
          ),
          
          const SizedBox(width: 16),
          
          // Informações de Texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vet['nome'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700, // Negrito para o nome
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  vet['endereco'],
                  style: const TextStyle(
                    fontSize: 13,
                    color: corTextoCinza,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                
                // Distância com ícone pequeno
                Row(
                  children: [
                    const Icon(Icons.near_me, size: 14, color: corBrand),
                    const SizedBox(width: 4),
                    Text(
                      _formatarDistancia(vet['distanciaMetros']),
                      style: const TextStyle(
                        color: corBrand,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Seta indicativa
          const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFFBDBDBD)),
        ],
      ),
    );
  }
}