import React, { useState } from 'react';
import { motion } from 'motion/react';
import Swal from 'sweetalert2';
import { MapPin, Phone, Mail } from 'lucide-react';
import { Language, translations } from '../translations';

export const Contact = ({ lang }: { lang: Language }) => {
    const t = translations[lang].contact;

    const address = import.meta.env.VITE_ADDRESS || '',
        phone = import.meta.env.VITE_PHONE || '',
        email = import.meta.env.VITE_EMAIL || '';

    const [loading, setLoading] = useState(false);
    const [formData, setFormData] = useState({
        name: '',
        email: '',
        comment: ''
    });

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);

        try {
            const response = await fetch(import.meta.env.VITE_CONTACT_API_URL, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData),
            });

            if (response.ok) {
                Swal.fire({
                    title: t.notifications.successTitle,
                    text: t.notifications.successText,
                    icon: 'success',
                    confirmButtonColor: '#2563eb',
                });
                setFormData({ name: '', email: '', comment: '' });
            } else {
                throw new Error('Failed to send message');
            }
        } catch (error) {
            Swal.fire({
                title: t.notifications.errorTitle,
                text: t.notifications.errorText,
                icon: 'error',
                confirmButtonColor: '#2563eb',
            });
        } finally {
            setLoading(false);
        }
    };

    return (
        <section id="contact" className="py-24 bg-white dark:bg-dark-bg transition-colors">
            <motion.div
                initial={{ opacity: 0, y: 50 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.8, ease: "easeOut" }}
                className="max-w-7xl mx-auto px-6"
            >
                <div className="grid lg:grid-cols-2 gap-20">
                    <div>
                        <h2 className="text-4xl uppercase  font-extrabold text-slate-900 dark:text-white mb-8">
                            {t.title}
                        </h2>
                        <p className="text-xl text-slate-600 dark:text-slate-300 mb-12">
                            {t.desc}
                        </p>

                        <div className="space-y-8">
                            <div className="flex gap-6">
                                <div className="w-12 h-12 bg-brand-50 dark:bg-brand-900/30 rounded-xl flex items-center justify-center text-brand-600">
                                    <MapPin size={24} />
                                </div>
                                <div>
                                    <h4 className="font-bold text-slate-900 dark:text-white mb-1">{t.info.address}</h4>
                                    <p className="text-slate-500 dark:text-slate-400">{address} - {t.info.country}</p>
                                </div>
                            </div>
                            <div className="flex gap-6">
                                <div className="w-12 h-12 bg-blue-50 dark:bg-blue-900/30 rounded-xl flex items-center justify-center text-blue-600">
                                    <Phone size={24} />
                                </div>
                                <div>
                                    <h4 className="font-bold text-slate-900 dark:text-white mb-1">{t.info.phone}</h4>
                                    <p className="text-slate-500 dark:text-slate-400">{phone}</p>
                                </div>
                            </div>
                            <div className="flex gap-6">
                                <div className="w-12 h-12 bg-purple-50 dark:bg-purple-900/30 rounded-xl flex items-center justify-center text-purple-600">
                                    <Mail size={24} />
                                </div>
                                <div>
                                    <h4 className="font-bold text-slate-900 dark:text-white mb-1">{t.info.email}</h4>
                                    <p className="text-slate-500 dark:text-slate-400">{email}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div className="bg-slate-50 dark:bg-dark-card/30 p-8 lg:p-12 rounded-[40px] border border-slate-100 dark:border-slate-600">
                        <form className="space-y-6" onSubmit={handleSubmit}>
                            <div className="grid md:grid-cols-2 gap-6">
                                <div>
                                    <label className="block text-sm font-bold text-slate-700 dark:text-slate-300 mb-2">{t.form.name}</label>
                                    <input
                                        type="text"
                                        required
                                        value={formData.name}
                                        onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                                        className="w-full px-5 py-4 bg-white dark:bg-dark-card border border-slate-200 dark:border-slate-600 rounded-2xl focus:ring-2 focus:ring-brand-500 outline-none transition-all dark:text-white"
                                    />
                                </div>
                                <div>
                                    <label className="block text-sm font-bold text-slate-700 dark:text-slate-300 mb-2">{t.form.email}</label>
                                    <input
                                        type="email"
                                        required
                                        value={formData.email}
                                        onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                                        className="w-full px-5 py-4 bg-white dark:bg-dark-card border border-slate-200 dark:border-slate-600 rounded-2xl focus:ring-2 focus:ring-brand-500 outline-none transition-all dark:text-white"
                                    />
                                </div>
                            </div>
                            <div>
                                <label className="block text-sm font-bold text-slate-700 dark:text-slate-300 mb-2">{t.form.message}</label>
                                <textarea
                                    rows={4}
                                    required
                                    value={formData.comment}
                                    onChange={(e) => setFormData({ ...formData, comment: e.target.value })}
                                    className="w-full px-5 py-4 bg-white dark:bg-dark-card border border-slate-200 dark:border-slate-600 rounded-2xl focus:ring-2 focus:ring-brand-500 outline-none transition-all dark:text-white"
                                ></textarea>
                            </div>
                            <button
                                type="submit"
                                disabled={loading}
                                className="w-full py-5 bg-brand-600 text-white font-bold rounded-2xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all disabled:opacity-70 disabled:cursor-not-allowed flex items-center justify-center gap-2"
                            >
                                {loading ? (
                                    <>
                                        <div className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin" />
                                        Send ...
                                    </>
                                ) : (
                                    t.form.send
                                )}
                            </button>
                        </form>
                    </div>
                </div>
            </motion.div>
        </section>
    );
};
