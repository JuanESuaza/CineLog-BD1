import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { AuthService } from '../../services/auth.service';
import { DetailModalComponent } from '../../components/detail-modal/detail-modal.component';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, RouterLink, FormsModule, DetailModalComponent],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  porGenero = signal<any[]>([]);
  top10 = signal<any[]>([]);
  resultados = signal<any[]>([]);
  loading = signal(true);
  selectedId = signal<number | null>(null);
  busqueda = '';
  tipoFiltro = '';
  generoFiltro = '';
  generos = signal<any[]>([]);
  modoFiltro = signal(false);

  constructor(private api: ApiService, public auth: AuthService, private route: ActivatedRoute) {}

  ngOnInit() {
    this.api.getGeneros().subscribe((g: any) => this.generos.set(g));
    this.route.queryParams.subscribe(params => {
      if (params['busqueda'] || params['tipo']) {
        this.busqueda = params['busqueda'] || '';
        this.tipoFiltro = params['tipo'] || '';
        this.modoFiltro.set(true);
        this.buscar();
      } else {
        this.modoFiltro.set(false);
        this.loadHome();
      }
    });
  }

  loadHome() {
    this.loading.set(true);
    this.api.getTop10().subscribe((top: any) => this.top10.set(top));
    this.api.getContenidosPorGenero().subscribe({
      next: (data: any) => { this.porGenero.set(data); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  buscar() {
    this.loading.set(true); this.modoFiltro.set(true);
    const params: any = {};
    if (this.busqueda) params.busqueda = this.busqueda;
    if (this.tipoFiltro) params.tipo = this.tipoFiltro;
    if (this.generoFiltro) params.genero = this.generoFiltro;
    this.api.getContenidos(params).subscribe({
      next: (data: any) => { this.resultados.set(data); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  limpiarFiltros() {
    this.busqueda = ''; this.tipoFiltro = ''; this.generoFiltro = '';
    this.modoFiltro.set(false); this.loadHome();
  }

  abrirDetalle(id: number) { this.selectedId.set(id); }
  cerrarDetalle() { this.selectedId.set(null); }
}
