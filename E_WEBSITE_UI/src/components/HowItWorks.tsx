import React from 'react';
import { motion } from 'motion/react';
import { UserCog, GraduationCap, Users, LayoutDashboard } from 'lucide-react';
import { Language, translations } from '../translations';

export const HowItWorks = ({ lang }: { lang: Language }) => {
  const t = translations[lang].howItWorks;
  const roles = [
    { icon: <UserCog size={32} />, color: "bg-blue-500" },
    { icon: <GraduationCap size={32} />, color: "bg-brand-500" },
    { icon: <Users size={32} />, color: "bg-purple-500" },
    { icon: <LayoutDashboard size={32} />, color: "bg-orange-500" }
  ];

  return (
    <section id="how-it-works" className="py-16 bg-slate-50 dark:bg-dark-bg text-slate-900 dark:text-white overflow-hidden transition-colors">
      <div className="max-w-7xl mx-auto px-6">
        <motion.div 
          initial={{ opacity: 0, y: 50 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.8, ease: "easeOut" }}
          className="flex flex-col lg:flex-row justify-between items-end mb-20 gap-8"
        >
          <div className="max-w-2xl">
            <h2 className="text-4xl uppercase  font-extrabold mb-6 text-slate-900 dark:text-white">{t.title}</h2>
            <p className="text-xl text-slate-600 dark:text-slate-400">
              {t.desc}
            </p>
          </div>
          <div className="hidden lg:block">
            <div className="flex items-center gap-4 px-6 py-3 bg-white dark:bg-white/5 rounded-full border border-slate-200 dark:border-white/10">
              <div className="w-3 h-3 bg-brand-500 rounded-full animate-pulse" />
              <span className="text-sm font-medium text-slate-600 dark:text-slate-300">{t.status}</span>
            </div>
          </div>
        </motion.div>

        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
          {t.roles.map((role, idx) => (
            <motion.div 
              key={idx}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              transition={{ delay: idx * 0.1 }}
              viewport={{ once: true }}
              className="group p-8 bg-white dark:bg-white/5 border border-slate-200 dark:border-white/10 rounded-[32px] hover:bg-slate-50 dark:hover:bg-white/10 transition-all cursor-default shadow-sm dark:shadow-none"
            >
              <div className={`w-16 h-16 ${roles[idx].color} text-white rounded-2xl flex items-center justify-center mb-8 shadow-lg group-hover:scale-110 transition-transform`}>
                {roles[idx].icon}
              </div>
              <h3 className="text-2xl font-bold mb-4 text-slate-900 dark:text-white">{role.role}</h3>
              <p className="text-slate-600 dark:text-slate-400 leading-relaxed">{role.desc}</p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
};
