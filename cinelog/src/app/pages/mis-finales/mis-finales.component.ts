import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApiService } from '../../services/api.service';
import { DetailModalComponent } from '../../components/detail-modal/detail-modal.component';

@Component({
  selector: 'app-mis-finales',
  standalone: true,
  imports: [CommonModule, DetailModalComponent],
  templateUrl: './mis-finales.component.html',
  styleUrls: ['./mis-finales.component.scss']
})
export class MisFinalesComponent implements OnInit {
  finales = signal<any[]>([]);
  loading = signal(true);
  selectedId = signal<number | null>(null);
  expandido = signal<number | null>(null);

  constructor(private api: ApiService) {}

  ngOnInit() {
    this.api.getMisFinales().subscribe({
      next: (data: any) => { this.finales.set(data); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  toggleExpand(id: number) { this.expandido.set(this.expandido() === id ? null : id); }
  isExpanded(id: number): boolean { return this.expandido() === id; }
  abrirDetalle(id: number) { this.selectedId.set(id); }
  cerrarDetalle() { this.selectedId.set(null); }
  preview(txt: string): string { return txt.length > 200 ? txt.slice(0,200) + '...' : txt; }
}
