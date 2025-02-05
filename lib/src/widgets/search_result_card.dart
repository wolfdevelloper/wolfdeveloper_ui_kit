import 'package:flutter/material.dart';

import 'expandable_content.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    super.key,
    required this.imageUrl,
    required this.providerName,
    required this.providerAddress,
    required this.rating,
    required this.reviewCount,
    required this.expandableContentList,
  });

  final String imageUrl;
  final String providerName;
  final String providerAddress;
  final double rating;
  final int reviewCount;
  final List<ExpandableContent> expandableContentList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 386,
      height: 386,
      child: Card(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120, // Largura da imagem/quadrado
                  height: 120,
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Imagem carregada
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                // Exibe um indicador de progresso enquanto carrega
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          ),
                        )
                      : Container(
                          color: Colors.grey[300],
                        ), // Quadrado cinza
                ),
                Expanded(
                  // Para ocupar o espaço restante
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          providerName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                providerAddress,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Avaliações ($reviewCount)',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconTheme(
                              data: const IconThemeData(
                                size: 16,
                                color: Colors.amber,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < rating
                                        ? Icons.star
                                        : Icons.star_border,
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              // Para o SingleChildScrollView ocupar o espaço restante
              child: SingleChildScrollView(
                child: Column(
                  children: expandableContentList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
