import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { ToastService } from '../../services/toast.service';
import { DetailModalComponent } from '../../components/detail-modal/detail-modal.component';

@Component({
  selector: 'app-mis-listas',
  standalone: true,
  imports: [CommonModule, FormsModule, DetailModalComponent],
  templateUrl: './mis-listas.component.html',
  styleUrls: ['./mis-listas.component.scss']
})
export class MisListasComponent implements OnInit {
  listas = signal<any[]>([]);
  loading = signal(true);
  creandoLista = signal(false);
  selectedId = signal<number | null>(null);
  nuevaLista = { nombre: '', descripcion: '' };
  mostrarForm = signal(false);

  constructor(private api: ApiService, private toast: ToastService) {}

  ngOnInit() { this.loadListas(); }

  toggleForm() { this.mostrarForm.set(!this.mostrarForm()); }

  loadListas() {
    this.loading.set(true);
    this.api.getListas().subscribe({
      next: (data: any) => { this.listas.set(data); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  crearLista() {
    if (!this.nuevaLista.nombre.trim()) { this.toast.show('El nombre es obligatorio', 'error'); return; }
    this.creandoLista.set(true);
    this.api.crearLista(this.nuevaLista).subscribe({
      next: () => {
        this.toast.show('Lista creada');
        this.nuevaLista = { nombre: '', descripcion: '' };
        this.mostrarForm.set(false);
        this.creandoLista.set(false);
        this.loadListas();
      },
      error: () => { this.toast.show('Error al crear', 'error'); this.creandoLista.set(false); }
    });
  }

  mover(idLista: number, idContenido: number, direccion: string) {
    this.api.moverEnLista(idLista, idContenido, direccion).subscribe({
      next: () => this.loadListas(),
      error: () => this.toast.show('Error al reordenar', 'error')
    });
  }

  eliminarDeLista(idLista: number, idContenido: number) {
    this.api.quitarDeLista(idLista, idContenido).subscribe({
      next: () => { this.toast.show('Eliminado de la lista'); this.loadListas(); },
      error: () => this.toast.show('Error', 'error')
    });
  }

  eliminarLista(idLista: number) {
    if (!confirm('Eliminar esta lista?')) return;
    this.api.eliminarLista(idLista).subscribe({
      next: () => { this.toast.show('Lista eliminada'); this.loadListas(); },
      error: () => this.toast.show('Error', 'error')
    });
  }

  abrirDetalle(id: number) { this.selectedId.set(id); }
  cerrarDetalle() { this.selectedId.set(null); this.loadListas(); }
}