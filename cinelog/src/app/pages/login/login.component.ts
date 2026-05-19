import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { ToastService } from '../../services/toast.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  mode = signal<string>('login');
  loading = signal(false);
  loginData = { correo_electronico: '', contrasenia: '' };
  registerData = { primer_nombre: '', primer_apellido: '', nombre_usuario: '', correo_electronico: '', contrasenia: '', fecha_nacimiento: '' };

  constructor(private auth: AuthService, private router: Router, private toast: ToastService) {
    if (auth.isLoggedIn()) router.navigate(['/home']);
  }

  setMode(m: string) { this.mode.set(m); }

  async onLogin() {
    if (!this.loginData.correo_electronico || !this.loginData.contrasenia) { this.toast.show('Completa todos los campos', 'error'); return; }
    this.loading.set(true);
    try { await this.auth.login(this.loginData); this.router.navigate(['/home']); }
    catch (e: any) { this.toast.show(e.error?.error || 'Error al iniciar sesion', 'error'); }
    finally { this.loading.set(false); }
  }

  async onRegister() {
    const d = this.registerData;
    if (!d.primer_nombre || !d.primer_apellido || !d.nombre_usuario || !d.correo_electronico || !d.contrasenia || !d.fecha_nacimiento) {
      this.toast.show('Completa todos los campos', 'error'); return;
    }
    this.loading.set(true);
    try { await this.auth.register(d); this.router.navigate(['/home']); }
    catch (e: any) { this.toast.show(e.error?.error || 'Error al registrarse', 'error'); }
    finally { this.loading.set(false); }
  }
}
